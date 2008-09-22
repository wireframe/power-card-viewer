require 'rubygems'
require 'yaml'
require 'active_support'
require 'haml'

powers = YAML.load(File.read('powers.yml'))
powers.each_with_index do |p,i|
  p[:id] = i
end
class_categories = powers.map {|p| p[:category]}.uniq.delete_if {|p| p =~ /(Epic|Feat|Racial)/}.sort
other_categories = ['Epic', 'Feat', 'Racial']

engine = Haml::Engine.new(File.read('powers.html.haml'))

File.open('index.html', 'w') { |f| f << engine.render(Object.new, :powers => powers, :class_categories => class_categories, :other_categories => other_categories) }
