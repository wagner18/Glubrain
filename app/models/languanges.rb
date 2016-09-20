class Languages

  PROPERTIES = [:list]
  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize
    @list = language_list
  end

  def language_list
    {
      "ar"=>"Arabic",
      "bg"=>"Bulgarian",
      "ca"=>"Catalan",
      "zh-CHS"=>"Chinese Simplified",
      "zh-CHT"=>"Chinese Traditional",
      "cs"=>"Czech",
      "da"=>"Danish",
      "nl"=>"Dutch",
      "en"=>"English",
      "et"=>"Estonian",
      "fi"=>"Finnish",
      "fr"=>"French",
      "de"=>"German",
      "el"=>"Greek",
      "ht"=>"Haitian Creole",
      "he"=>"Hebrew",
      "hi"=>"Hindi",
      "mww"=>"Hmong Daw",
      "hu"=>"Hungarian",
      "id"=>"Indonesian",
      "it"=>"Italian",
      "ja"=>"Japanese",
      "tlh"=>"Klingon",
      "ko"=>"Korean",
      "lv"=>"Latvian",
      "lt"=>"Lithuanian",
      "ms"=>"Malay",
      "mt"=>"Maltese",
      "no"=>"Norwegian",
      "fa"=>"Persian",
      "pl"=>"Polish",
      "pt"=>"Portuguese",
      "ro"=>"Romanian",
      "ru"=>"Russian",
      "sk"=>"Slovak",
      "sl"=>"Slovenian",
      "es"=>"Spanish",
      "sw"=>"Swahili",
      "sv"=>"Swedish",
      "th"=>"Thai",
      "tr"=>"Turkish",
      "uk"=>"Ukrainian",
      "ur"=>"Urdu",
      "vi"=>"Vietnamese",
      "cy"=>"Welsh",
    }
  end

end