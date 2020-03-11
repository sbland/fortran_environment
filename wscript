#!/usr/bin/env python3
import os
from waflib import Utils

APPNAME = 'fortran-environment'


if 'PREFIX' not in os.environ:
    os.environ['PREFIX'] = '.'



FCFLAGS = {}
FCFLAGS['GFORTRAN'] = '-Wall -Wextra -Wimplicit-interface -fimplicit-none -fPIC'.split()
FCFLAGS['GFORTRAN_debug'] = '-O0 -fmax-errors=1 -g -fcheck=all -fbacktrace'.split()
FCFLAGS['GFORTRAN_release'] = '-O2'.split()
FCFLAGS['IFORT'] = '-warn all -implicitnone -fpic'.split()
FCFLAGS['IFORT_debug'] = '-check all'.split()
FCFLAGS['IFORT_release'] = '-fast'.split()


def _flags_for_variant(compiler, variant):
    return FCFLAGS.get(compiler, []) + FCFLAGS.get(compiler + '_' + variant, [])

# Defines WAF options - https://waf.io/apidocs/Options.html
def options(ctx):
    # load compiler libraries (Adds commands to ctx)
    # https://waf.io/apidocs/tools/c_config.html
    ctx.load('compiler_c')
    # https://waf.io/apidocs/tools/fc_config.html
    ctx.load('compiler_fc')

def configure(ctx):
    print('Configuring')

    # load compilers and use them to check fortran
    ctx.load('compiler_c')
    ctx.load('compiler_fc')

    # Compiles a sample Fortran program to ensure that the settings are correct
    ctx.check_fortran()

    conf.start_msg('Using build variant')
    conf.end_msg(conf.options.variant)
    conf.env.FCFLAGS = conf.env.FCFLAGS or _flags_for_variant(conf.env.FC_NAME, conf.options.variant)
    conf.start_msg('FCFLAGS')
    conf.end_msg(' '.join(conf.env.FCFLAGS))

def build(ctx):
    print('Building')
    ctx(features='fc',
        source=ctx.path.ant_glob('src/*_ml.f90'),
        target='modules',
        use='LAPACK C_API')
    ctx(features='fc fcprogram',
        source='src/main.f90',
        target='run_model',
        use='modules')