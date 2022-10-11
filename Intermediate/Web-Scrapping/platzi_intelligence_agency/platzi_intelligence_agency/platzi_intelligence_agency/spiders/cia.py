import scrapy

LINKS_XPATH = '//a[starts-with(@href, "collection") and (parent::h3|parent::h2)]/@href'
TITLE_XPATH = '//h1[@class="documentFirstHeading"]/text()'
BODY_XPATH = '//div[@class="field-item even"]/p[not(@class)]/text()'

class CiaSpider(scrapy.Spider):
    
    name = 'cia'
    start_urls = [
        'https://www.cia.gov/readingroom/historical-collections'
    ]
    
    custom_settings = {
        'FEED_URI' : 'cia.json',
        'FEED_FORMAT' : 'json',
        'FEED_EXPORT_ENCODING' : 'utf-8',
        'ROBOTSTXT_OBEY' : True,
    }
    
    def parse(self, response):
        
        links_declassified = response.xpath(LINKS_XPATH).getall()
        
        for link in links_declassified:
            yield response.follow(link, callback=self.parse_link, cb_kwargs = {'url' : response.urljoin(link)})
    
    
    def parse_link(self, response, **kwargs):
        link = kwargs['url']
        
        title = response.xpath(TITLE_XPATH).get()
        body = response.xpath(BODY_XPATH).get()
        
        yield {
            'url' : link,
            'title' : title,
            'body' : body,
        }