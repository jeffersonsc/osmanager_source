#encoding: utf-8
require 'rubygems'
require 'active_record'
require 'pg'
require '/home/jefferson/osmanager_source/app/models/arquivo.rb'

begin
	ActiveRecord::Base.establish_connection({
		:adapter => "postgresql",
		:host => "localhost",
		:username => "jefferson",
		:password => "je@14051994",
		:database => "osmanagerdb"
	})
	puts "===================== INICIANDO SCRIPT DE UPLOAD DE CONTRATOS ======================"
	@contrato_id = ARGV[0]
	@path_file = ARGV[1]

	@file = File.open(@path_file , "r")

	@contrato = Arquivo.create(:contrato_id => @contrato_id , :content_type => ARGV[2] , :filename => ARGV[3] , :contrato_bin => @file.read)

	system("rm -rf #{@path_file}")

	puts "======================= FIM DO SCRIPT ====================================="
rescue => erro
	puts "=============================== ERRO ============================="
	puts erro
end
