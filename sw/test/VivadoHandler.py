import subprocess

class VivadoHandler(object):
    executable = 'vivado'

    def __init__(self,
                 mode = 'batch',
                 debug = ['-nojournal', '-nolog', '-notrace'],
                 extra_args = ["-m64"]):

        self.mode = mode
        self.debug = debug
        self.args = extra_args

    def run_tcl(self, tcl):
        command = [self.executable, '-mode', self.mode,  *self.debug,
                   *self.args, '-source', tcl]
        result = subprocess.run(command, capture_output=True)

        return result
