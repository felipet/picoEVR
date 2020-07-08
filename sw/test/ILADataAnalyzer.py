from pandas import read_csv

class ILADataAnalyzer(object):

    def load_csv(self, filename):
        # First row: col names, Second row: data type
        self.data = read_csv(filename, sep=',')
        # We need to remove the first row because it is not valid data
        self.data = self.data.drop(0)

    def detect_evnt_code(self, evnt_code, signal):
        # First get the full column name for the target signal
        col_idx = ""
        for c in self.data.columns:
            if signal in c:
                col_idx = c
                break

        if col_idx == "":
            return -1, "The signal was not found!"

        code = "{:02x}00".format(evnt_code)

        for x in self.data[col_idx]:
            if x == code:
                return 0, "The event code {} was found!".format(code)
        else:
            return -2, "The event code {} was not found!".format(code)
