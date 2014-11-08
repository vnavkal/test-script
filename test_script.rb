l = YAML.load_file('/home/viraj/upstart_share/shared_data/production_tests/upstart_71989.yaml')
l.rate_coefs_for_loan_amounts = nil
l.rejected = nil

a = (1..10).to_a.map do
m = UpstartNetwork::LoanPricing::LoanModel.new(l)
i = m.get_interest_rate(l.raising_amount)
i.interest_rate_percent
end

l.revolving_credit_accounts_balance += 7500
l.revolving_credit_utilized_percent += 100.0 * 7500 / l.total_revolving_limit
l.bankcard_credit_utilized_percent += 100.0 * 7500 / l.total_bankcard_limit
l.debt_available_for_refi += 7500

srand(0)
a = []
i = 0
Upstart.last(100).each do |upstart|
  puts "iteration #{i}"
  i += 1
  begin
    terms = UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan)
    credit_report = upstart.normal_soft_credit_report
    data = Loans::PricingData.new_from_upstart(upstart, terms, credit_report)
    m = UpstartNetwork::LoanPricing::LoanModel.new(data)
    a << m.get_interest_rate(data.raising_amount).interest_rate_percent
  rescue
    nil
  end
end


srand(0)
terms = UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan)
upstart = Upstart.find(63644)
credit_report = upstart.normal_soft_credit_report
data = Loans::PricingData.new_from_upstart(upstart, terms, credit_report)
m = UpstartNetwork::LoanPricing::LoanModel.new(data)
i = m.get_interest_rate(data.raising_amount)
i.interest_rate_percent


15.982542491588868


# master
[Float::INFINITY, 8.737624900363034, Float::INFINITY, 10.293188782588224, Float::INFINITY, Float::INFINITY, 10.361688775681689, Float::INFINITY, Float::INFINITY, Float::INFINITY, 13.580690413225252, Float::INFINITY, Float::INFINITY, Float::INFINITY, 12.918318862591978, Float::INFINITY, 8.51035290828569, Float::INFINITY, 10.800902839201965, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, 7.585503805654978, Float::INFINITY, Float::INFINITY, Float::INFINITY, 7.138901935018688, Float::INFINITY, Float::INFINITY, 13.64293043547468, Float::INFINITY, 10.068030583913497, Float::INFINITY, 10.655915603868502, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, 12.811436361703233, Float::INFINITY, 7.259670896471957, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, 11.149366015709711, 6.908033228612567, Float::INFINITY, Float::INFINITY, Float::INFINITY, 13.442310526320885]



# refactor-simulation
[Float::INFINITY, 8.737624900363034, Float::INFINITY, 10.293188782588224, Float::INFINITY, Float::INFINITY, 10.361688775681689, Float::INFINITY, Float::INFINITY, Float::INFINITY, 13.580690413225252, Float::INFINITY, Float::INFINITY, Float::INFINITY, 12.918318862591978, Float::INFINITY, 8.51035290828569, Float::INFINITY, 10.800902839201965, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, 7.585503805654978, Float::INFINITY, Float::INFINITY, Float::INFINITY, 7.138901935018688, Float::INFINITY, Float::INFINITY, 13.64293043547468, Float::INFINITY, 10.068030583913497, Float::INFINITY, 10.655915603868502, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, 12.811436361703233, Float::INFINITY, 7.259670896471957, Float::INFINITY, Float::INFINITY, Float::INFINITY, Float::INFINITY, 11.149366015709711, 6.908033228612567, Float::INFINITY, Float::INFINITY, Float::INFINITY, 13.442310526320885]
