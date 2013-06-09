'''
Created on 13 april 2013

@author: vl
'''

class Analyser(object):
    '''
    classdocs
    '''
    
    def __init__(self, filepath):
        '''
        Constructor
        '''
        self.__filepath = filepath
        self.__data = []
    
    def load_file(self):
        '''
        Load data from log file
        '''
        log_file = open(self.__filepath,'r')
        data = log_file.readlines()
        log_file.close()
        for line in data:
            self.append_record(line.split())
        return self
    
    def append_record(self, record):
        '''
        Append record
        '''
        self.__data.append(record)
        return self
    
    def get_data(self):
        '''
        Get data
        '''
        return self.__data
    
    def unique_visitors(self):
        '''
        Return array of unique visitors (ip)
        '''
        visitors = self.all_visitors()
        visitors = list(set(visitors))
        return visitors
    
    def all_visitors(self):
        '''
        Return array of visitors and count of visits
        '''
        visitors = list()
        for record in self.__data:
            visitors.append(record[0])
        return visitors
    
    def visitors_by_resources(self):
        '''
        Return dictionary of visitors and resources count
        '''
        visitors = dict()
        for record in self.__data:
            if visitors.has_key(record[0]):
                visitors[record[0]] += 1
            else:
                visitors[record[0]] = 1
        
        return visitors
    
    def resources_by_countries(self):
        '''
        Return dictionary of resources and caoutries from which it's was loaded
        '''
        resources = dict()
        for record in self.__data:
            if resources.has_key(record[2]):
                resources[record[2]] += 1
            else:
                resources[record[2]] = 1
        return resources
        