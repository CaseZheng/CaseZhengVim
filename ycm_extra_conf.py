from distutils.sysconfig import get_python_inc
import platform
import os
import subprocess
import ycm_core
import sys

DIR_OF_THIS_SCRIPT = os.path.abspath("bundle/YouCompleteMe/third_party/ycmd")
DIR_OF_THIRD_PARTY = os.path.join( DIR_OF_THIS_SCRIPT, 'third_party' )
SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c', '.m', '.mm' ]

flags = [
'-x', 'c++',
# 显示所有警告
'-Wall',
# 打印更多的警告信息
'-Wextra',
# 将警告视为错误
# '-Werror',
# 如果使用了long long 类型就发出警告
# '-Wno-long-long',
'-Wno-variadic-macros',
'-fexceptions',
'-stdlib=libc++',
'-std=c++11',
# 忽略所有断言
'-DNDEBUG',
]

# 系统库
selfFlags = [
]

for v in selfFlags:
    flags.append("-I")
    flags.append(os.path.expanduser('~/') + v)
    pass

# 项目文件
path_file = os.getcwd() + "/you.files"
if os.path.exists(path_file):
    fp = open(path_file, "r")
    path_set = set(os.path.dirname(p) for p in fp.readlines())
    for v in path_set:
        flags.append("-I")
        flags.append(v)
    fp.close()

compilation_database_folder = ''
if os.path.exists( compilation_database_folder ):
  database = ycm_core.CompilationDatabase( compilation_database_folder )
else:
  database = None

def IsHeaderFile( filename ):
  extension = os.path.splitext( filename )[ 1 ]
  return extension in [ '.h', '.hxx', '.hpp', '.hh' ]

def FindCorrespondingSourceFile( filename ):
  if IsHeaderFile( filename ):
    basename = os.path.splitext( filename )[ 0 ]
    for extension in SOURCE_EXTENSIONS:
      replacement_file = basename + extension
      if os.path.exists( replacement_file ):
        return replacement_file
  return filename

def PathToPythonUsedDuringBuild():
  try:
    filepath = os.path.join( DIR_OF_THIS_SCRIPT, 'PYTHON_USED_DURING_BUILDING' )
    with open( filepath ) as f:
      return f.read().strip()
  # We need to check for IOError for Python 2 and OSError for Python 3.
  except ( IOError, OSError ):
    return None

def Settings( **kwargs ):
  language = kwargs[ 'language' ]

  if language == 'cfamily':
    filename = FindCorrespondingSourceFile( kwargs[ 'filename' ] )

    if not database:
      return {
        'flags': flags,
        'include_paths_relative_to_dir': DIR_OF_THIS_SCRIPT,
        'override_filename': filename
      }

    compilation_info = database.GetCompilationInfoForFile( filename )
    if not compilation_info.compiler_flags_:
      return {}

    final_flags = list( compilation_info.compiler_flags_ )

    try:
      final_flags.remove( '-stdlib=libc++' )
    except ValueError:
      pass

    return {
      'flags': final_flags,
      'include_paths_relative_to_dir': compilation_info.compiler_working_dir_,
      'override_filename': filename
    }

  if language == 'python':
    return {
      'interpreter_path': PathToPythonUsedDuringBuild()
    }

  return {}


def GetStandardLibraryIndexInSysPath( sys_path ):
  for index, path in enumerate( sys_path ):
    if os.path.isfile( os.path.join( path, 'os.py' ) ):
      return index
  raise RuntimeError( 'Could not find standard library path in Python path.' )


def PythonSysPath( **kwargs ):
  sys_path = kwargs[ 'sys_path' ]

  sys_path.insert( 0, DIR_OF_THIS_SCRIPT )

  for folder in os.listdir( DIR_OF_THIRD_PARTY ):
    if folder == 'python-future':
      folder = os.path.join( folder, 'src' )
      sys_path.insert( GetStandardLibraryIndexInSysPath( sys_path ) + 1,
                       os.path.realpath( os.path.join( DIR_OF_THIRD_PARTY,
                                                       folder ) ) )
      continue

    if folder == 'cregex':
      interpreter_path = kwargs[ 'interpreter_path' ]
      major_version = subprocess.check_output( [
        interpreter_path, '-c', 'import sys; print( sys.version_info[ 0 ] )' ]
      ).rstrip().decode( 'utf8' )
      folder = os.path.join( folder, 'regex_{}'.format( major_version ) )

    sys_path.insert( 0, os.path.realpath( os.path.join( DIR_OF_THIRD_PARTY,
                                                        folder ) ) )
  return sys_path
