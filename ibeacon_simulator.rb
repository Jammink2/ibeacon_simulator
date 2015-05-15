#!/usr/bin/ruby
require 'td'

#Ibeacon simulator script for Treasure Data.  
#This script takes write api key and number of records you want to add as command-line args 
#example usage: $ ruby ibeacon_simulator.rb "5919/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" 500
#john@johnhamm.ink

#Initialization

api_key = ARGV[0]
iterator = ARGV[1].to_i
TreasureData::Logger.open('ibeacon_test', 
							:apikey=> api_key, 
							:auto_create_table=> true)

def generate_uuid(length=27)
	chars = '1234567890'
	uuid_1 = Array.new(length) { chars[rand(chars.length)].chr }.join
	return uuid_1
end

def generate_major(length=5)
	chars = '1234567890'
	major1 = Array.new(length) { chars[rand(chars.length)].chr }.join.to_i
	return major1
end

def generate_measuredPower()
	measuredPower1 = [-39, -40, -41, -42, -43, -44, -45, -46, -47, -48, -49, -51, -53, -55, -57, -59, -61, -63, -65].sample
	return measuredPower1
end

def generate_rssi()
	rssi_1 = [ -21, -27, -28, -29, -30, -31, -37, -41, -47, -51, -57, -61, -67, -77, -89, -95, -100].sample
	return rssi_1
end

def generate_accuracy_substring(length=16)
	chars = '1234567890'
	accuracy_substring = Array.new(length) { chars[rand(chars.length)].chr }.join
	return accuracy_substring
end

def choose_proximity()
	proximity_choice = ['near', 'immediate'].sample
	return proximity_choice
end

for i in 0..iterator
	#Get values
	measuredPower_var = generate_measuredPower
	uuid_var = generate_uuid
	major_var = generate_major
	minor_var = 23276
	measuredPower_var = generate_measuredPower
	accuracy_var_conv = "0." + generate_accuracy_substring
	accuracy_var_float = Float(accuracy_var_conv)
	proximity_var = choose_proximity
	rssi_var = generate_rssi
	
	#Log events to TD
	TD.event.post('events', {proximity: proximity_var, minor: minor_var, rssi: rssi_var, uuid: uuid_var, accuracy: accuracy_var_float, major: major_var,  measuredPower: measuredPower_var})
end
TreasureData::Logger.logger.flush()
