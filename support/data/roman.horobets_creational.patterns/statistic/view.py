'''
Created on 13 april 2013

@author: vl
'''

class CLIView(object):
    '''
    classdocs
    '''

    def __init__(self, analyser):
        '''
        Constructor
        '''
        self.__analyser = analyser
        
    def render(self):
        '''
        Render full statistic to string
        '''
        result = "Log statistic\n"
        result += "-"*50
        result += "\nUnique Visitors:\n"
        result += self.get_unique_visitors()
        result += "\nAll Visitors:\n"
        result += self.get_all_visitors()
        result += "\nVisitors by resources:\n"
        result += self.get_visitors_by_resources()
        result += "\nResources by countries:\n"
        result += self.get_resources_by_countries()
        return result
        
    def get_unique_visitors(self):
        '''
        Render unique visitors to string
        '''
        return "\n".join(self.__analyser.unique_visitors())
    
    def get_all_visitors(self):
        '''
        Render all visitors to string
        '''
        return "\n".join(self.__analyser.all_visitors())
    
    def get_visitors_by_resources(self):
        '''
        Render visitors with resources count to string
        '''
        visitors = self.__analyser.visitors_by_resources()
        result = []
        for visitor in visitors:
            result.append(visitor+' '+str(visitors[visitor]))
        return "\n".join(result)
    
    def get_resources_by_countries(self):
        '''
        Render countries with resources count to string
        '''
        resources = self.__analyser.resources_by_countries()
        result = []
        for resource in resources:
            result.append(resource+' '+str(resources[resource]))
        return "\n".join(result)