statuses=["出品中", "取引中", "売却済み", "出品停止中"]
statuses.each do |status|
Status.create!(name:status)
end