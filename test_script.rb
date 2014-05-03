u = Upstart.find(17649)
manager = UpstartNetwork::AutomaticLoanPricingManager.new(u)
manager.pre_price
t = FundingTermSetTemplate.all.find { |t| t.contract_type == UpstartNetwork::LoanTerms::CONTRACT_TYPE }
t.enabled = true
t.save!

l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

monthly_compensation = 55000/12.0
is_current = true
j = UpstartNetwork::LoanPricing::Job.new(monthly_compensation.to_f, Date.new(2010, 2, 3), Date.new(2014, 2, 3), is_current)
l.jobs = [j]

l.coding_bootcamp = nil
l.total_monthly_debt_obligations=180+533
l.student_sat_1600=1190
l.school_sat_1600 = 1250
l.college_gpa_4 = 3.26
l.number_of_dependents = 0
l.home_ownership.monthly_price = 945
l.undergrad_bb_major = :'health professions'

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(5000)

rate_array = (1..2).map { |x| x * 200 + 0 }.map do |monthly_payment|
  rates = []
  l.total_monthly_debt_obligations = monthly_payment
  l.rejected = nil
  l.rate_coefs_for_loan_amounts = nil
  m = UpstartNetwork::LoanPricing::LoanModel.new(l)
  coefs = m.rate_coefs_for_loan_amounts
  rejected = m.rejected
  [0, 3, 6].map do |deferral|
    # Instantiate using estimator coefs
    l.rejected = rejected
    l.rate_coefs_for_loan_amounts = coefs # This won't work!!!
    l.deferral_months = deferral
    m = UpstartNetwork::LoanPricing::LoanModel.new(l)
    if m.get_maximum_loan_amount > 5000
      m.get_interest_rate(5000).interest_rate_percent
    else
      Float::INFINITY
    end
  end
end


c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c
m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(5000)



l.rejected = false
l.rate_coefs_for_loan_amounts = [-9.479187120998635e-09, 0.0006116425522770213, 10.180444627019057]
m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(5000)

# Price B&B respondents
UpstartNetwork::LoanPricing::LoanModel.bb_pricing(file = '/home/viraj/upstart/data/bb_test_cases/bb_people.csv', output_file = '/home/viraj/upstart/data/bb_test_cases/bb_people_output_m10def1-1d60s15n1btbgp8.csv', num_people = nil, bootcamp = true)

# Simulate B&B respondents
UpstartNetwork::LoanPricing::LoanModel.bb_simulation(file = '/home/viraj/upstart/data/bb_test_cases/bb_people_for_simulation.csv',
                                                     output_file = '/home/viraj/upstart/data/bb_test_cases/bb_people_simulated.csv',
                                                     num_people = 5)

# Price BPS respondents
UpstartNetwork::LoanPricing::LoanModel.bps_pricing(file = '/home/viraj/upstart/data/bps_test_cases/bps_test_cases.csv', output_file = '/home/viraj/upstart/data/bps_test_cases/bps_people_output_location.csv', num_people = nil, bootcamp = false, credit_variation_list = [])

# Simulate BPS respondents
UpstartNetwork::LoanPricing::LoanModel.bps_simulation(file = '/home/viraj/upstart/data/bps_test_cases/bps_test_cases_for_simulation.csv', output_file = '/home/viraj/upstart/data/bps_test_cases/bps_people_simulated.csv', num_people = nil)

m.write_simulation_arrays(5000, 20, '/home/viraj/upstart/data/simulation_arrays/', 'bootcamp')


# Candidate 1
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

job1 = UpstartNetwork::LoanPricing::Job.new(4250.0, Date.new(2013, 5, 3), Date.new(2014, 4, 1), true)
job2 = UpstartNetwork::LoanPricing::Job.new(2750.0, Date.new(2012, 9, 3), Date.new(2013, 5, 3), false)
l.jobs = [job1, job2]

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.student_sat_1600 = 1280
l.school_sat_1600 = 1014
l.college_gpa_4 = 3.3
l.number_of_dependents = 0
l.home_ownership.monthly_price = 1000
l.home_ownership.ownership_type = "rent"
l.undergrad_bb_major = :other
l.raising_amount = 15000

l.open_credit_lines = 1
l.total_monthly_debt_obligations=0
l.revolving_credit_accounts_balance = 500
l.revolving_credit_utilized_percent = 16.67
l.credit_score = 680
l.delinquencies_in_2_years = 0
l.recent_credit_inquiries = 1
l.public_records_on_file = 0
l.credit_history_month = 48
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP
l.total_credit_lines_count = 1
l.deferral_months = 6
l.college_grad_year = 2010

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 2

l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

job1 = UpstartNetwork::LoanPricing::Job.new(4250.0, Date.new(2013, 5, 3), Date.new(2014, 4, 1), true)
job2 = UpstartNetwork::LoanPricing::Job.new(2750.0, Date.new(2012, 9, 3), Date.new(2013, 5, 3), false)
l.jobs = [job1, job2]

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.student_sat_1600 = nil
l.school_sat_1600 = 1304
l.college_gpa_4 = nil
l.number_of_dependents = 0
l.home_ownership.monthly_price = 1000
l.home_ownership.ownership_type = "rent"
l.undergrad_bb_major = :other
l.raising_amount = 15000

l.open_credit_lines = 1
l.total_monthly_debt_obligations=0
l.revolving_credit_accounts_balance = 500
l.revolving_credit_utilized_percent = 16.67
l.credit_score = 680
l.delinquencies_in_2_years = 0
l.recent_credit_inquiries = 1
l.public_records_on_file = 0
l.credit_history_month = 48
l.use_of_funds = UseOfFunds::CODING_BOOTCAMP
l.total_credit_lines_count = 1
l.deferral_months = 6
l.college_grad_year = 2010

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 3

l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

job1 = UpstartNetwork::LoanPricing::Job.new(5000.0, Date.new(2011, 1, 1), Date.new(2014, 1, 1), false)
job2 = UpstartNetwork::LoanPricing::Job.new(2750.0, Date.new(2012, 9, 3), Date.new(2013, 5, 3), false)
l.jobs = [job1]

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.student_sat_1600 = nil
l.school_sat_1600 = 1366
l.college_gpa_4 = nil
l.number_of_dependents = 0
l.home_ownership.monthly_price = 800.0
l.home_ownership.ownership_type = "rent"
l.undergrad_bb_major = :'social sciences'
l.raising_amount = 12000

l.open_credit_lines = 6
l.total_monthly_debt_obligations = 494
l.revolving_credit_accounts_balance = 10701
l.revolving_credit_utilized_percent = 21
l.credit_score = 756
l.delinquencies_in_2_years = 0
l.recent_credit_inquiries = 3
l.public_records_on_file = 0
l.credit_history_month = 85
l.use_of_funds = UseOfFunds::CODING_BOOTCAMP
l.total_credit_lines_count = 8
l.deferral_months = 0
l.college_grad_year = 2010

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 4

l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

job1 = UpstartNetwork::LoanPricing::Job.new(51252.0 / 12.0, Date.new(2011, 4, 1), Date.new(2014, 4, 1), true)
job2 = UpstartNetwork::LoanPricing::Job.new(2750.0, Date.new(2012, 9, 3), Date.new(2013, 5, 3), false)
l.jobs = [job1]

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.student_sat_1600 = nil
l.school_sat_1600 = 1309
l.college_gpa_4 = nil
l.number_of_dependents = 0
l.home_ownership.monthly_price = 675.0
l.home_ownership.ownership_type = "rent"
l.undergrad_bb_major = :'social sciences'
l.raising_amount = 14000

l.open_credit_lines = 6
l.total_monthly_debt_obligations = 638
l.revolving_credit_accounts_balance = 48
l.revolving_credit_utilized_percent = 0
l.credit_score = 790
l.delinquencies_in_2_years = 0
l.recent_credit_inquiries = 0
l.public_records_on_file = 0
l.credit_history_month = 120
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP
l.total_credit_lines_count = 12
l.deferral_months = 0
l.college_grad_year = 2008

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 5

l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

job1 = UpstartNetwork::LoanPricing::Job.new(0.0, Date.new(2013, 6, 1), nil, true)
job2 = UpstartNetwork::LoanPricing::Job.new(2750.0, Date.new(2012, 9, 3), Date.new(2013, 5, 3), false)
l.jobs = [job1]

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.student_sat_1600 = nil
l.school_sat_1600 = 1373
l.college_gpa_4 = nil
l.number_of_dependents = 0
l.home_ownership.monthly_price = 0.0
l.home_ownership.ownership_type = "rent"
l.undergrad_bb_major = :humanities
l.raising_amount = 11000

l.open_credit_lines = 3
l.total_monthly_debt_obligations = 181
l.revolving_credit_accounts_balance = 4855
l.revolving_credit_utilized_percent = 7
l.credit_score = 730
l.delinquencies_in_2_years = 0
l.recent_credit_inquiries = 0
l.public_records_on_file = 0
l.credit_history_month = 119
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP
l.total_credit_lines_count = 6
l.deferral_months = 0
l.college_grad_year = 1998

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 6

l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

job1 = UpstartNetwork::LoanPricing::Job.new(42000.0 / 12.0, Date.new(2012, 2, 1), nil, true)
job2 = UpstartNetwork::LoanPricing::Job.new(19200.0 / 12.0, Date.new(2007, 10, 1), Date.new(2012,2,1), false)
l.jobs = [job1, job2]

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.raising_amount = 10000
l.student_sat_1600 = nil
l.school_sat_1600 = nil
l.college_gpa_4 = nil
l.number_of_dependents = 0
l.home_ownership.monthly_price = 700.0
l.home_ownership.ownership_type = "rent"
l.undergrad_bb_major = nil
l.total_monthly_debt_obligations = 0

l.credit_score = 770
l.credit_history_month = 56
l.delinquencies_in_2_years = 0
l.open_credit_lines = 4
l.total_credit_lines_count = 6
l.revolving_credit_accounts_balance = 177
l.revolving_credit_utilized_percent = 2
l.recent_credit_inquiries = 0
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP

l.deferral_months = 0
l.college_grad_year = nil

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 7

l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.raising_amount = 12000

l.student_sat_1600 = nil
l.school_sat_1600 = 1340
l.college_gpa_4 = nil
l.undergrad_bb_major = :business
l.college_grad_year = 2009

job1 = UpstartNetwork::LoanPricing::Job.new(45000.0 / 12.0, Date.new(2009, 9, 1), nil, true)
job2 = UpstartNetwork::LoanPricing::Job.new(19200.0 / 12.0, Date.new(2007, 10, 1), Date.new(2012,2,1), false)
l.jobs = [job1]

l.number_of_dependents = 0
l.home_ownership.monthly_price = 1760.0
l.home_ownership.ownership_type = "rent"

l.total_monthly_debt_obligations = 428.0
l.credit_score = 710
l.credit_history_month = 15 * 12
l.delinquencies_in_2_years = 0
l.open_credit_lines = 6
l.total_credit_lines_count = 7
l.revolving_credit_accounts_balance = 14908
l.revolving_credit_utilized_percent = 74
l.recent_credit_inquiries = 1
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 8: 17649
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = nil

l.raising_amount = 25000
l.use_of_funds = UpstartNetwork::UseOfFunds::STUDENT_LOAN_REFINANCING

l.student_sat_1600 = nil
l.school_sat_1600 = 1198
l.college_gpa_4 = 3.8
l.undergrad_bb_major = :business
l.college_grad_year = 2011

job1 = UpstartNetwork::LoanPricing::Job.new(12600.0 / 12.0, Date.new(2011, 9, 1), nil, true)
job2 = UpstartNetwork::LoanPricing::Job.new(60000.0 / 12.0, Date.new(2011, 6, 1), Date.new(2011,9,1), false)
l.jobs = [job1, job2]

l.number_of_dependents = 0
l.home_ownership.monthly_price = 950.0
l.home_ownership.ownership_type = "mortgage"

l.total_monthly_debt_obligations = 316.0
l.credit_score = 790
l.credit_history_month = 30 * 12
l.delinquencies_in_2_years = 0
l.open_credit_lines = 8
l.total_credit_lines_count = 10
l.revolving_credit_accounts_balance = 5007
l.revolving_credit_utilized_percent = 6
l.recent_credit_inquiries = 0

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 9: 17516
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.raising_amount = 20000
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP

l.student_sat_1600 = nil
l.school_sat_1600 = 1383
l.college_gpa_4 = nil
l.undergrad_bb_major = "Humanities"
l.college_grad_year = 1999

job1 = UpstartNetwork::LoanPricing::Job.new(73200.0 / 12.0, Date.new(2013, 11, 1), nil, true)
job2 = UpstartNetwork::LoanPricing::Job.new(68400.0 / 12.0, Date.new(2013, 7, 1), Date.new(2013, 11, 1), false)
job3 = UpstartNetwork::LoanPricing::Job.new(45600.0 / 12.0, Date.new(2012, 2, 1), Date.new(2013, 7, 1), false)
l.jobs = [job1, job2, job3]

l.number_of_dependents = 0
l.total_monthly_debt_obligations = 1811.0
l.home_ownership.monthly_price = 600.0
l.home_ownership.ownership_type = "rent"

l.credit_score = 704
l.credit_history_month = 222
l.delinquencies_in_2_years = 1
l.open_credit_lines = 1
l.total_credit_lines_count = 6
l.revolving_credit_accounts_balance = 0
l.revolving_credit_utilized_percent = 0
l.recent_credit_inquiries = 0

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 10: 17485
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = nil

l.raising_amount = 25000
l.use_of_funds = UpstartNetwork::UseOfFunds::STARTUP_OR_BUSINESS

l.student_sat_1600 = nil
l.school_sat_1600 = 0.5 * (1459 + 1434)
l.college_gpa_4 = nil
l.undergrad_bb_major = :'math and other sciences'
l.college_grad_year = 2008

job1 = UpstartNetwork::LoanPricing::Job.new(104400.0 / 12.0, Date.new(2013, 10, 1), nil, true)
job2 = UpstartNetwork::LoanPricing::Job.new(68400.0 / 12.0, Date.new(2011, 11, 1), Date.new(2013, 9, 1), false)
l.jobs = [job1, job2]

l.number_of_dependents = 0
l.total_monthly_debt_obligations = 0
l.home_ownership.monthly_price = 900
l.home_ownership.ownership_type = "rent"

l.credit_score = 730
l.credit_history_month = 31 * 12
l.delinquencies_in_2_years = 0
l.open_credit_lines = 2
l.total_credit_lines_count = 2
l.revolving_credit_accounts_balance = 4287
l.revolving_credit_utilized_percent = 36
l.recent_credit_inquiries = 1

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 11: 17471
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.raising_amount = 13000
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP

l.student_sat_1600 = nil
l.school_sat_1600 = 1331
l.college_gpa_4 = nil
l.undergrad_bb_major = 'Social sciences'
l.college_grad_year = 2007

job1 = UpstartNetwork::LoanPricing::Job.new(24000.0 / 12.0, Date.new(2013, 6, 1), Date.new(2014, 2, 1), false)
l.jobs = [job1]

l.number_of_dependents = 0
l.total_monthly_debt_obligations = 143
l.home_ownership.monthly_price = 0.0
l.home_ownership.ownership_type = "none"

l.credit_score = 717
l.credit_history_month = 103
l.delinquencies_in_2_years = 0
l.open_credit_lines = 3
l.total_credit_lines_count = 3
l.revolving_credit_accounts_balance = 4659
l.revolving_credit_utilized_percent = 35
l.recent_credit_inquiries = 0

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 12: 17773
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.raising_amount = 10000
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP

l.student_sat_1600 = 1450
l.school_sat_1600 = 1134
l.college_gpa_4 = 3.47
l.undergrad_bb_major = 'Education'
l.college_grad_year = 2012

job1 = UpstartNetwork::LoanPricing::Job.new(18000.0 / 12.0, Date.new(2013, 1, 1), nil, true)
job2 = UpstartNetwork::LoanPricing::Job.new(15600.0 / 12.0, Date.new(2012, 6, 1), Date.new(2012, 12, 1), false)
l.jobs = [job1, job2]

l.number_of_dependents = 0
l.total_monthly_debt_obligations = 532
l.home_ownership.monthly_price = 0.0
l.home_ownership.ownership_type = "none"

l.credit_score = 710
l.credit_history_month = 68
l.delinquencies_in_2_years = 0
l.open_credit_lines = 2
l.total_credit_lines_count = 2
l.revolving_credit_accounts_balance = 6962
l.revolving_credit_utilized_percent = 57
l.recent_credit_inquiries = 3

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 13: Henry Harrison
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.raising_amount = 15000
l.use_of_funds = UpstartNetwork::UseOfFunds::EDUCATION

l.student_sat_1600 = nil
l.school_sat_1600 = 1415
l.college_gpa_4 = nil
l.undergrad_bb_major = :humanities
l.college_grad_year = 2009

job1 = UpstartNetwork::LoanPricing::Job.new(20400.0 / 12.0, Date.new(2011, 9, 1), nil, true)
l.jobs = [job1]

l.number_of_dependents = 0
l.total_monthly_debt_obligations = 0
l.home_ownership.monthly_price = 362.0
l.home_ownership.ownership_type = "rent"

l.credit_score = 770
l.credit_history_month = 9 * 12
l.delinquencies_in_2_years = 0
l.open_credit_lines = 5
l.total_credit_lines_count = 6
l.revolving_credit_accounts_balance = 1297
l.revolving_credit_utilized_percent = 4
l.recent_credit_inquiries = 0

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 14: 17997
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.raising_amount = 10000
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP

l.student_sat_1600 = nil
l.school_sat_1600 = 1113
l.college_gpa_4 = nil
l.undergrad_bb_major = :humanities
l.college_grad_year = 2007

job1 = UpstartNetwork::LoanPricing::Job.new(57500.0 / 12.0, Date.new(2009, 8, 1), nil, true)
l.jobs = [job1]

l.number_of_dependents = 0
l.total_monthly_debt_obligations = 180
l.home_ownership.monthly_price = 180.0
l.home_ownership.ownership_type = "mortgage"

l.credit_score = 770
l.credit_history_month = 15 * 12
l.delinquencies_in_2_years = 0
l.open_credit_lines = 15
l.total_credit_lines_count = 16
l.revolving_credit_accounts_balance = 9715
l.revolving_credit_utilized_percent = 7
l.recent_credit_inquiries = 3

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount)

# Candidate 14: 17997
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.raising_amount = 10000
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP

l.student_sat_1600 = nil
l.school_sat_1600 = 972
l.college_gpa_4 = nil
l.undergrad_bb_major = :history
l.college_grad_year = 2007

job1 = UpstartNetwork::LoanPricing::Job.new(57000.0 / 12.0, Date.new(2009, 8, 1), nil, true)
l.jobs = [job1]

l.number_of_dependents = 0
l.total_monthly_debt_obligations = 180
l.home_ownership.monthly_price = 900.0
l.home_ownership.ownership_type = "mortgage"

l.credit_score = 764
l.credit_history_month = 185
l.delinquencies_in_2_years = 0
l.open_credit_lines = 15
l.total_credit_lines_count = 16
l.revolving_credit_accounts_balance = 9715
l.revolving_credit_utilized_percent = 7
l.recent_credit_inquiries = 3

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
i = m.get_interest_rate(l.raising_amount)
{'interest rate' => i.interest_rate_percent, 'apr' => i.apr}

# Candidate 15: 17405
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.raising_amount = 10000
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP

l.student_sat_1600 = nil
l.school_sat_1600 = 1333
l.college_gpa_4 = nil
l.undergrad_bb_major = :'social sciences'
l.college_grad_year = 2004

job1 = UpstartNetwork::LoanPricing::Job.new(63000.0 / 12.0, Date.new(2013, 5, 1), nil, true)
job2 = UpstartNetwork::LoanPricing::Job.new(61200.0 / 12.0, Date.new(2013, 5, 1), Date.new(2005, 1, 1), false)
l.jobs = [job1, job2]

l.number_of_dependents = 0
l.total_monthly_debt_obligations = 813
l.home_ownership.monthly_price = 1100.0
l.home_ownership.ownership_type = "rent"

l.credit_score = 750
l.credit_history_month = 15 * 12
l.delinquencies_in_2_years = 1
l.open_credit_lines = 8
l.total_credit_lines_count = 18
l.revolving_credit_accounts_balance = 1737
l.revolving_credit_utilized_percent = 3
l.recent_credit_inquiries = 1

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
i = m.get_interest_rate(l.raising_amount)
{'interest rate' => i.interest_rate_percent, 'apr' => i.apr}

# Candidate 16: 16325
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = nil

l.raising_amount = 15000
l.use_of_funds = UpstartNetwork::UseOfFunds::CREDIT_CARD_REFINANCING

l.student_sat_1600 = nil
l.school_sat_1600 = 1320
l.college_gpa_4 = nil
l.undergrad_bb_major = :engineering
l.college_grad_year = 2011

job1 = UpstartNetwork::LoanPricing::Job.new(75000.0 / 12.0, Date.new(2013, 5, 1), nil, true)
job2 = UpstartNetwork::LoanPricing::Job.new(57000.0 / 12.0, Date.new(2012, 1, 1), Date.new(2013, 5, 1), false)
l.jobs = [job1, job2]

l.number_of_dependents = 1
l.total_monthly_debt_obligations = 553
l.home_ownership.monthly_price = 700.0
l.home_ownership.ownership_type = "mortgage"

l.credit_score = 690
l.credit_history_month = 11 * 12
l.delinquencies_in_2_years = 0
l.open_credit_lines = 7
l.total_credit_lines_count = 8
l.revolving_credit_accounts_balance = 17310
l.revolving_credit_utilized_percent = 34
l.recent_credit_inquiries = 4

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
i = m.get_interest_rate(l.raising_amount)
{'interest rate' => i.interest_rate_percent, 'apr' => i.apr}

# Candidate 17: 18143
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.raising_amount = 25000
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP

l.student_sat_1600 = nil
l.school_sat_1600 = 1343
l.college_gpa_4 = nil
l.undergrad_bb_major = :'social sciences'
l.college_grad_year = 2010

job1 = UpstartNetwork::LoanPricing::Job.new(7000.0, Date.new(2013, 5, 1), nil, true)
l.jobs = [job1]

l.number_of_dependents = 0
l.total_monthly_debt_obligations = 111
l.home_ownership.monthly_price = 1500.0
l.home_ownership.ownership_type = "rent"

l.credit_score = 683
l.credit_history_month = 96
l.delinquencies_in_2_years = 0
l.open_credit_lines = 18
l.total_credit_lines_count = 25
l.revolving_credit_accounts_balance = 19960
l.revolving_credit_utilized_percent = 14
l.recent_credit_inquiries = 4

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
i = m.get_interest_rate(l.raising_amount)
{'interest rate' => i.interest_rate_percent, 'apr' => i.apr}

# Candidate 18: 18008
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.raising_amount = 16000
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP

l.student_sat_1600 = nil
l.school_sat_1600 = nil
l.college_gpa_4 = nil
l.undergrad_bb_major = nil
l.college_grad_year = nil

job1 = UpstartNetwork::LoanPricing::Job.new(7000.0, Date.new(2013, 5, 1), nil, true)
l.jobs = []

l.number_of_dependents = 2
l.total_monthly_debt_obligations = 0
l.home_ownership.monthly_price = 0.0
l.home_ownership.ownership_type = "none"

l.credit_score = 650
l.credit_history_month = 32
l.delinquencies_in_2_years = 2
l.open_credit_lines = 4
l.total_credit_lines_count = 4
l.revolving_credit_accounts_balance = 501
l.revolving_credit_utilized_percent = 22
l.recent_credit_inquiries = 1

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
i = m.get_interest_rate(l.raising_amount)
{'interest rate' => i.interest_rate_percent, 'apr' => i.apr}

# Candidate 16: 17099
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = c

l.raising_amount = 22000
l.use_of_funds = UpstartNetwork::UseOfFunds::CODING_BOOTCAMP

l.student_sat_1600 = nil
l.school_sat_1600 = 1157.0
l.college_gpa_4 = nil
l.undergrad_bb_major = :humanities
l.college_grad_year = 2001

job1 = UpstartNetwork::LoanPricing::Job.new(13200.0 / 12.0, Date.new(2013, 5, 1), nil, true)
job2 = UpstartNetwork::LoanPricing::Job.new(7756.0 / 12.0, Date.new(2014, 1, 1), nil, true)
job3 = UpstartNetwork::LoanPricing::Job.new(16800.0 / 12.0, Date.new(2007, 9, 1), Date.new(2012, 12, 1), false)
l.jobs = [job1, job2, job3]

l.number_of_dependents = 0
l.total_monthly_debt_obligations = 611
l.home_ownership.monthly_price = 1125.0
l.home_ownership.ownership_type = "rent"

l.credit_score = 710
l.credit_history_month = 16 * 12
l.delinquencies_in_2_years = 1
l.open_credit_lines = 7
l.total_credit_lines_count = 9
l.revolving_credit_accounts_balance = 6981
l.revolving_credit_utilized_percent = 16
l.recent_credit_inquiries = 0

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
i = m.get_interest_rate(l.raising_amount)
{'interest rate' => i.interest_rate_percent, 'apr' => i.apr}

# Candidate 17: 17967
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = nil

l.raising_amount = 5000
l.use_of_funds = UpstartNetwork::UseOfFunds::LARGE_PURCHASE

l.student_sat_1600 = nil
l.school_sat_1600 = 1086.0
l.college_gpa_4 = 3.45
l.undergrad_bb_major = :engineering
l.college_grad_year = 2013

job1 = UpstartNetwork::LoanPricing::Job.new(57996.0 / 12.0, Date.new(2013, 6, 1), nil, true)
l.jobs = [job1]

l.number_of_dependents = 0
l.total_monthly_debt_obligations = 433
l.home_ownership.monthly_price = 800.0
l.home_ownership.ownership_type = "rent"

l.credit_score = 690
l.credit_history_month = 60
l.delinquencies_in_2_years = 0
l.open_credit_lines = 4
l.total_credit_lines_count = 4
l.revolving_credit_accounts_balance = 4072
l.revolving_credit_utilized_percent = 33
l.recent_credit_inquiries = 1

l.deferral_months = 0

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
i = m.get_interest_rate(l.raising_amount)
{'interest rate' => i.interest_rate_percent, 'apr' => i.apr}

# Playing around
l = UpstartNetwork::LoanPricingData.new_from_upstart(u, UpstartNetwork::LoanTerms.new(FundingTermSetTemplate.template_loan))

job1 = UpstartNetwork::LoanPricing::Job.new(4500.0, Date.new(2013, 4, 1), nil, true)
job2 = UpstartNetwork::LoanPricing::Job.new(3500.0, Date.new(2011, 9, 3), Date.new(2013, 4, 1), false)
l.jobs = [job1]#, job2]

job_offer = UpstartNetwork::LoanPricing::JobOffer.new(4000.0, Date.new(2014, 5, 1))
l.job_offers = []#[job_offer]

c = CodingBootcamp.where(use_for_pricing: true).first
l.coding_bootcamp = nil

l.student_sat_1600 = 1100
l.school_sat_1600 = 1100
l.college_gpa_4 = 3.0
l.number_of_dependents = 0
l.home_ownership.monthly_price = 1500
l.home_ownership.ownership_type = "rent"
l.undergrad_bb_major = 'Business'
l.raising_amount = 5000

l.open_credit_lines = 0
l.total_monthly_debt_obligations = 700
l.revolving_credit_accounts_balance = 0
l.revolving_credit_utilized_percent = 0
l.credit_score = 750
l.delinquencies_in_2_years = 0
l.recent_credit_inquiries = 0
l.public_records_on_file = 0
l.credit_history_month = 40
l.use_of_funds = UpstartNetwork::UseOfFunds::CREDIT_CARD_REFINANCING
l.total_credit_lines_count = 5
l.deferral_months = 0
l.college_grad_year = 2014

m = UpstartNetwork::LoanPricing::LoanModel.new(l)
m.get_interest_rate(l.raising_amount).interest_rate_percent
