module XMLParse

  class XMLParserDelegate

    attr_reader :root

    def initialize
      @root = nil
      @queue = []
      @content = []
    end

    def parser(parser, didStartElement:elementName, namespaceURI:namespaceURI, qualifiedName:qualifiedName, attributes:attributeDict)

      el = XMLElement.new(elementName, attributeDict)

      if @queue.empty?
        @root = el 
      else
        @queue[-1].add_child(el)
      end

      @queue << el
    end

    # as the parser finds characters, this method is being called
    def parser(parser, foundCharacters: content)
      @content << content
    end

    # method called when an element is done being parsed
    def parser(parser, foundCharacters:string, didEndElement:elementName, namespaceURI:namespaceURI, qualifiedName:qName)
      @queue.pop
    end

    def get_content
      @content
    end

    def get_content_hash
      content_hash = {}
      get_content.each{ |c|
        content_hash[c] = "#{c}"
      }
      content_hash
    end

  end

  class XMLElement
    attr_accessor :name, :attributes, :children

    def initialize(name, attributes)
      @el = name
      @attributes = attributes
      @children = []
    end

    def add_child(el)
      @children << el
    end

    def to_xml
      if @children.empty?
        '<' + @el + attrs_as_xml + '/>'
      else
        '<' + @el + attrs_as_xml + '>' + @children.map(&:to_xml).join + '</' + @el + '>'
      end
    end

    private
    def attrs_as_xml
      @attributes.map { |k, v| ' ' + k.to_s + '="' + v.to_s + '"' }.join
    end
  end

end