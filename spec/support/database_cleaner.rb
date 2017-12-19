RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:deletion)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, threads: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :deletion
    FactoryBot.reload
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:context, noclean: true) do |group|
    DatabaseCleaner.strategy = example_group.class.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end
  config.after(:context, noclean: true) do |group|
    DatabaseCleaner.clean
  end

end