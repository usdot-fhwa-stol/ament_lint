# Copyright 2023 Open Source Robotics Foundation, Inc.
# Copyright 2024 Leidos
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Changes from original Open Source Robotics Foundation, Inc. version:
#   - replaced ament_clang_tidy with carma_ament_clang_tidy to avoid name collisions

from setuptools import find_packages
from setuptools import setup

package_name = 'carma_ament_clang_tidy'

setup(
    name=package_name,
    version='0.9.8',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/' + package_name, ['package.xml']),
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
    ],
    install_requires=['setuptools', 'pyyaml'],
    package_data={'': [
        'configuration/.clang-tidy',
    ]},
    zip_safe=False,
    author='John Shepherd',
    author_email='john@openrobotics.org',
    maintainer='John Shepherd',
    maintainer_email='john@openrobotics.org',
    url='https://github.com/ament/ament_lint',
    download_url='https://github.com/ament/ament_lint/releases',
    keywords=['ROS'],
    classifiers=[
        'Intended Audience :: Developers',
        'License :: OSI Approved :: Apache Software License',
        'Programming Language :: Python',
        'Topic :: Software Development',
    ],
    description='Check C++ code style using clang-tidy.',
    long_description="""\
The ability to check code against style conventions using clang-tidy
and generate xUnit test result files.""",
    license='Apache License, Version 2.0, BSD',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'carma_ament_clang_tidy = carma_ament_clang_tidy.main:main',
        ],
    },
)
