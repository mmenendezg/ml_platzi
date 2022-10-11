import scrapy

# title = '//h1/a/text()'
# quotes = '//span[@class="text" and itemprop="text"]/text()'
# top_ten_quotes = '//div[contains(@class, "tags-box")]//span[@class="tag-item"]/a/text()'

class QuotesSpider(scrapy.Spider):
    
    name = 'quotes'
    start_urls = [
        'http://quotes.toscrape.com'
    ]
    custom_settings =  {
        'FEED_URI' : 'quotes.json',
        'FEED_FORMAT' : 'json',
        'CONCURRENT_REQUESTS' : 24,
        'MEMUSAGE_LIMITS_MB' : 2048,
        'MEMUSAGE_NOTIFY_MAIL' : ['marlon.menendezg@gmail.com'],
        'ROBOTSTXT_OBEY' : True,
        'USER_AGENT' : 'MarlonMenendez',
        'FEED_EXPORT_ENCODING' : 'utf-8',
    }
    
    
    def parse_only_quotes(self, response, **kwargs):
        if kwargs:
            quotes = kwargs['quotes']
        
        quotes.extend(self._get_all_quotes(response))
        
        next_page_button_link = response.xpath('//ul[@class="pager"]//li[@class="next"]/a/@href').get()
        if next_page_button_link:
            yield response.follow(next_page_button_link, callback=self.parse_only_quotes, cb_kwargs={'quotes' : quotes})
        else:
            yield {
                'quotes' : quotes
            }
    
    def parse(self, response):
        
        title = response.xpath('//h1/a/text()').get()
        quotes = self._get_all_quotes(response)
        top_tags = response.xpath('//div[contains(@class, "tags-box")]//span[@class="tag-item"]/a/text()').getall()
        
        top = getattr(self, 'top', None)
        
        if top:
            top = int(top)
            top_tags = top_tags[:top]
        
        data = {
            'title' : title,
            'top_ten_tags' : top_tags
        }
        
        yield data
        
        next_page_button_link = response.xpath('//ul[@class="pager"]//li[@class="next"]/a/@href').get()
        if next_page_button_link:
            yield response.follow(next_page_button_link, callback=self.parse_only_quotes, cb_kwargs={'quotes' : quotes})

    def _get_all_quotes(self, response):
        
        list_quotes = response.xpath('//div[@class="quote"]').getall()
        
        quotes = []
        for quote in list_quotes:
            quote_content = response.xpath('//span[@class="text"]/text()').get()
            quote_author = response.xpath('//small[@class="author"]/text()').get()
            
            quotes.append({
                'author' : quote_author,
                'quote' : quote_content,
            })
        
        yield quotes