from HTMLParser import HTMLParser
import sys


class MyHTMLParser(HTMLParser):

    def __init__(self):
        HTMLParser.__init__(self)
        self.is_title = False
        self.is_author = False
        self.url = ""
        self.author_list = []

    def handle_starttag(self, tag, attrs):
        if tag == 'a':
            for name, value in attrs:
                if name == 'href' and 'http://dl.acm.org' in value:
                    self.url = value
        if tag == 'span':
            name, value = attrs[0]
            if name == 'class' and value == 'title':
                self.is_title = True
            elif name == 'itemprop' and value == 'name':
                self.is_author = True

    def handle_data(self, data):
        if self.is_author:
            self.is_author = False
            self.author_list.append(data)
        elif self.is_title:
            self.is_title = False
            title = data[:-1]
            print("<tr><td width=\"60%\"><a href=\"{}\">{}</a></td><td>{}</td></tr>".format(
                self.url, title, ', '.join(self.author_list)))
            self.author_list = []

parser = MyHTMLParser()
parser.feed(open(sys.argv[1]).read())
