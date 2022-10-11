import scrapy

class QuotesSpider(scrapy.Spider):
    
    name = 'quotes'
    start_urls = [
        'http://quotes.toscrape.com'
    ]
    
    def parse(self, response):
        print('*' * 10)
        print('\n\n')
        print(response.status)
        print('*' * 10)
        print('\n\n')
        print(response.headers)