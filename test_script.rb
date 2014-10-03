l = YAML.load_file('/home/viraj/upstart_share/shared_data/production_tests/upstart_71989.yaml')
l.rate_coefs_for_loan_amounts = nil
l.rejected = nil

a = (1..10).to_a.map do
m = UpstartNetwork::LoanPricing::LoanModel.new(l)
i = m.get_interest_rate(l.raising_amount)
i.interest_rate_percent
end
