#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Test Runner for the picoEVR Firmware
"""

__author__    = "Felipe Torres González"
__email__     = "felipe.torresgonzalez@ess.eu"
__copyright__ = "Copyright 2020, European Spallation Source"
__license__   = "GPL"
__version__   = "0.1"
__status__    = "Early"

import sys

if not sys.version_info >= (3, 5):
   print("Error: Python is too old! Please, update to a version newer than 3.5.")
   exit(-1)

import argparse

from VivadoHandler import VivadoHandler
from ILADataAnalyzer import ILADataAnalyzer

def main():
    """
    Test Runner for the picoEVR Firmware

    Covered by this test:
    - Link detection
    - Detection of comma characters (TODO)
    - [Optional] Detection of event codes sent by the master
    - [Optional] Check received event rate (TODO)

    Example of use:
        - TestRunner.py iladata.csv rx_data 170
          That command will run the test using the file 'iladata.csv' as data
          source. The test will filter the data looking for the event 170 in
          the column tagged by *rx_data*.

        - TestRunner.py iladata.csv rx_data 170 --acq test.tcl
          The test will call Vivado first to collect data using a physical
          deployment. It will generate the file 'iladata.csv' as data source.
          The test will filter the data looking for the event 170 in the column
          tagged by *rx_data*.

    Pre:
        - The input TCL file must point to the physical deployment. Right now,
          there's no
    """

    # Argument parser
    parser = argparse.ArgumentParser(description='picoEVR Firmware Test Runner')

    # Positional argument: Path to the CSV file with the data collected by the
    # Vivado HW Analyzer
    parser.add_argument('acq_data', metavar='acq_data', type=str,
        help='Filename for the collected data from the Vivado HW Analyzer.')
    # Positional argument: Name of the signal with the received event codes
    parser.add_argument('signal', metavar='signal_id', type=str,
        help='Signal name for the filtering.')
    # Positional argument: Event codes. A list of integers.
    parser.add_argument('events', metavar='events', type=int, nargs='+',
        help='List of event codes to search in the acquired data.')
    # Optional argument: Enable running the Vivado HW Analyzer to acquire a new
    # CSV file with data.
    parser.add_argument('--acq', type=str, help='If present, indicates the \
        source script filename to be passed to Vivado.')

    args = parser.parse_args()

    if args.acq :
        vivado = VivadoHandler()
        print("Running Vivado HW Analyzer...")
        output = vivado.run_tcl(args.acq)
        if "ERROR:" in str(output.stderr, 'utf-8'):
            print("Vivado failed, see the log output:")
            print(output)
            exit(-1)
        print("Finished")

    print("Checking for the event codes...")
    analyzer = ILADataAnalyzer()
    analyzer.load_csv(args.acq_data)
    for e in args.events:
        evnt_found = analyzer.detect_evnt_code(e, args.signal)
        print(evnt_found[-1])
        if evnt_found[0]:
            exit(evnt_found[0])

    print("Test done!")

    exit(0)

if __name__ == '__main__':
    main()
