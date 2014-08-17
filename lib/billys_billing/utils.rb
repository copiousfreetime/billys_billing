module BillysBilling
  module Utils
    def snake_to_camel( word )
      word = word.to_s
      return word unless word.index('_')
      leader, *parts = word.split('_')
      parts = parts.map { |p| p.capitalize }
      parts.unshift( leader )
      parts.join('')
    end
  end
end
