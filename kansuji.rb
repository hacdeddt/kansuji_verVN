class Kansuji
  MONEYS = { '10': 'mười', '9': 'chín', '8': 'tám', '7': 'bảy', '6': 'sáu', '5': 'năm', '4': 'bốn', '3': 'ba', '2': 'hai', '1': 'một', '0': 'mươi',
  			 '00': 'trăm', '000': 'nghìn', '0000': 'mươi', '00000': 'trăm', '000000': 'triệu', '0000000': 'mươi', '00000000': 'trăm' }

  def initialize(money)
  	@money = money
  end

  def result
  	if @money.class == Integer
  	  result = convert(@money, '').strip.gsub(/\s+/, " ")
  	else
  	  result = convert_text(@money, 0)
  	end
  	puts "----------- Result ------------"
  	puts result
  end

  def convert(money, text)
  	length_money = money.to_s.length - 1  #độ dài của số 0
  	return text += MONEYS[money.to_s.to_sym] + ' đồng' if length_money == 0 || money == 10
  	remaining_money = money / 10**length_money
  	if [1, 4, 7, 10].include?(length_money) && remaining_money == 1
  	  text += MONEYS['10'.to_sym] + ' '
  	else
  	  text += MONEYS[(remaining_money).to_s.to_sym] + ' ' + MONEYS[('0'*length_money).to_sym] + ' '
  	end
  	return text += MONEYS[('0'*(length_money -1)).to_sym].to_s + ' đồng' if money % 10**length_money == 0
  	convert(money % 10**length_money, text)
  end

  def convert_text(money, to_i)
  	words = money.downcase.split(' ')
  	words.delete('đồng')
  	words1, words2, split_monies = [], [], []
  	if words.include?('triệu')
  		words1 = words[0..words.index('triệu').to_i]
  		words = words[words.index('triệu').to_i + 1..-1]
  	end
  	if words.include?('nghìn')
  		words2 = words[0..words.index('nghìn')]
  		words = words[words.index('nghìn').to_i + 1..-1]
  	end
  	split_monies << words1 << words2 << words
  	split_monies.each do |words|
  		to_i += convert_text_to_i(words).to_i
  	end
  	to_i
  end

  def convert_text_to_i(words)
  	to_i = 0
  	units = ['mươi', 'trăm', 'nghìn', 'triệu']
  	for idx in (0...(words.length))
  	  to_i += 10 if words[idx] == 'mười' && words.length > 2
  	  next unless units.include?(words[idx]) || words.length == idx + 1
  	  if ['mươi', 'trăm'].include?(words[idx])
  	    to_i += MONEYS.key(words[idx - 1]).to_s.to_i * ('1' + MONEYS.key(words[idx]).to_s).to_i
  	  elsif ['nghìn', 'triệu'].include?(words.last)
  	  	to_i += MONEYS.key(words[idx - 1]).to_s.to_i
  	  else
  	  	to_i += MONEYS.key(words[idx]).to_s.to_i
  	  end
  	end
  	to_i = to_i * ('1' + MONEYS.key(words.last).to_s).to_i if ['nghìn', 'triệu'].include?(words.last)
  	to_i
  end
end

kansuji = Kansuji.new(11111111).result
kansuji = Kansuji.new(34523569).result
kansuji = Kansuji.new(10000000).result
kansuji = Kansuji.new(10000).result
kansuji = Kansuji.new(20000).result
kansuji = Kansuji.new(10).result
kansuji = Kansuji.new(50).result
kansuji = Kansuji.new(999999999).result
# kansuji = Kansuji.new('Tám').result
# kansuji = Kansuji.new('Mười').result
# kansuji = Kansuji.new('Một trăm ba mươi bốn đồng').result
# kansuji = Kansuji.new('Một nghìn hai trăm ba mươi bốn đồng').result
# kansuji = Kansuji.new('Mười hai nghìn ba trăm bốn mươi năm đồng').result
# kansuji = Kansuji.new('Hai mươi hai nghìn ba trăm bốn mươi năm đồng').result
# kansuji = Kansuji.new('Một trăm hai mươi ba nghìn bốn trăm tám mươi năm đồng').result
# kansuji = Kansuji.new('mười một triệu một trăm mười một nghìn một trăm mười một đồng').result
# kansuji = Kansuji.new('Một trăm triệu').result
# kansuji = Kansuji.new('Mười triệu').result