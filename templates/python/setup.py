from setuptools import setup, find_packages

setup(
    name='example_package',
    version='1.0.0',
    author='Your Name',
    author_email='your@email.com',
    description='A simple example package',
    long_description='A longer description of the package',
    url='https://github.com/yourusername/example_package',
    packages=find_packages(where='src'),
    package_dir={'': 'src'},
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
    ],
    python_requires='>=3.6',
    install_requires=[
        # Add any dependencies your package requires
        'requests',
        'numpy',
    ],
)
