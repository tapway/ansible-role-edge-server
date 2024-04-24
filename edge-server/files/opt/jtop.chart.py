# -*- coding: utf-8 -*-
# Description: howto weather station netdata python.d module
# Author: Panagiotis Papaioannou (papajohn-uop)
# SPDX-License-Identifier: GPL-3.0-or-later

from bases.FrameworkServices.SimpleService import SimpleService
try:
    from jtop import jtop
    JTOP = True
except ImportError:
    JTOP = False

ORDER = [
    "gpu_utilization",
    "gpu_temperature"
]

CHARTS = {
    "gpu_utilization":
    {
        "options": [None, "GPU Utilization", "%", "GPU", "gpu.utilization", "line"],
        "lines": [
            ["gpu_utilization"]
        ]
    },
    "gpu_temperature":
    {
        "options": [None, "GPU Temperature", "°C", "GPU", "gpu.temperature", "line"],
        "lines": [
            ["gpu_temp"]
        ]
    },
}


class Service(SimpleService):
    def __init__(self, configuration=None, name=None):
        SimpleService.__init__(self, configuration=configuration, name=name)
        self.order = ORDER
        self.definitions = CHARTS
        #values to show at graphs
        self.values=dict()

    def check(self):
        if not JTOP:
            self.error("'jetson-stats' module is needed to use jtop.chart.py")
            return False
        return True

    gpu_data = dict()
    gpu_metrics = {
        "gpu_utilization": "GPU",
        "gpu_temp": "Temp GPU",
    }

    def fetch_jtop_metrics(self):
        try:
            with jtop() as jetson:
                for metric, name in self.gpu_metrics.items():
                    self.gpu_data[metric] = jetson.stats.get(name)
        except Exception as e:
            print(e)

    def get_data(self):
        #The data dict is basically all the values to be represented
        # The entries are in the format: { "dimension": value}
        #And each "dimension" should belong to a chart.
        data = dict()

        self.fetch_jtop_metrics()

        data['gpu_utilization'] = self.gpu_data['gpu_utilization']
        data['gpu_temp'] = self.gpu_data['gpu_temp']
        return data
