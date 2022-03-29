namespace :db do
  desc 'csvをデータベースに取り込む'
  task :csv, ['model'] => :environment do |_task, args|
    require 'import_csv'
    ImportCsv.execute(model: args.model)
  end
end
