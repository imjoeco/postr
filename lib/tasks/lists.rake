desc "Create top lists for site"
task :create_lists => :environment do
  if PostDailyList.last.created_at + 1.hour < Time.now
    if PostDailyList.create
      PostWeeklyList.create
    end
  end
end
