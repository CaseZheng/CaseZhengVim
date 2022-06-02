import os
import platform
import subprocess
from distutils.sysconfig import get_python_inc

import ycm_core

DIR_OF_THIS_SCRIPT = os.path.abspath(os.path.dirname(__file__))
DIR_OF_THIRD_PARTY = DIR_OF_THIS_SCRIPT + '/plugged/YouCompleteMe/third_party'
SOURCE_EXTENSIONS = ['.cpp', '.cxx', '.cc', '.c', '.m', '.mm']

flags = [
    '-DNDEBUG',
    '-x',
    'c++',
    '-std=c++11',
]

# 公共库
dev_lib_path = os.getenv('DEV_LIBRARY_PATH')
if dev_lib_path is not None:
    dev_lib_path = dev_lib_path.split(';')
    for lib in dev_lib_path:
        if lib == '':
            continue
        flags.append("-I")
        flags.append(lib)
        path_dir_list = os.listdir(lib)
        for dir_name in path_dir_list:
            if dir_name in (".git", ".svn"):
                continue

            dir_path = lib + '/' + dir_name
            if not os.path.isdir(dir_path):
                continue

            flags.append("-I")
            flags.append(dir_path)

# 项目文件
project_path = os.getcwd()
path_dir_list = os.listdir(project_path)
for dir_name in path_dir_list:
    if not os.path.isdir(dir_name):
        continue

    if dir_name in (".git", ".svn"):
        continue

    flags.append("-I")
    flags.append(project_path + '/' + dir_name)


def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in ['.h', '.hxx', '.hpp', '.hh']


def FindCorrespondingSourceFile(filename):
    if IsHeaderFile(filename):
        basename = os.path.splitext(filename)[0]
        for extension in SOURCE_EXTENSIONS:
            replacement_file = basename + extension
            if os.path.exists(replacement_file):
                return replacement_file
    return filename


def Settings(**kwargs):
    if kwargs['language'] == 'cfamily':
        filename = FindCorrespondingSourceFile(kwargs['filename'])

        return {'flags': flags, 'include_paths_relative_to_dir': DIR_OF_THIS_SCRIPT, 'override_filename': filename}


def GetStandardLibraryIndexInSysPath(sys_path):
    for path in sys_path:
        if os.path.isfile(os.path.join(path, 'os.py')):
            return sys_path.index(path)
    raise RuntimeError('Could not find standard library path in Python path.')


def PythonSysPath(**kwargs):
    sys_path = kwargs['sys_path']

    for folder in os.listdir(DIR_OF_THIRD_PARTY):
        if folder == 'python-future':
            folder = os.path.join(folder, 'src')
            sys_path.insert(
                GetStandardLibraryIndexInSysPath(sys_path) + 1,
                os.path.realpath(os.path.join(DIR_OF_THIRD_PARTY, folder)))
            continue

        if folder == 'cregex':
            interpreter_path = kwargs['interpreter_path']
            major_version = subprocess.check_output(
                [interpreter_path, '-c', 'import sys; print( sys.version_info[ 0 ] )']).rstrip().decode('utf8')
            folder = os.path.join(folder, 'regex_{}'.format(major_version))

        sys_path.insert(0, os.path.realpath(os.path.join(DIR_OF_THIRD_PARTY, folder)))
    return sys_path
