class Seed
  def self.start
    new.generate
  end

  def generate
    create_categories
    create_roles
    create_admins
    create_borrowers
    create_projects
    create_lenders
    create_loans
    create_sample_accounts
    create_sample_data
  end

  def create_categories
    categories = ["Andhra Pradesh",
                  "Telangana",
                  "Karnataka",
                  "Tamil Nadu",
                  "Kerala",
                  "Uttar Pradesh",
                  "Maharashtra",
                  "Punjab",
                  "Gujarat",
                  "West Bengal"]
    categories.each do |title|
      Category.create!(title: title)
      puts "Created Category: #{title}"
    end

    @ap = Category.find_by(title: "Andhra Pradesh")
    @te = Category.find_by(title: "Telangana")
    @ka = Category.find_by(title: "Karnataka")
    @tn = Category.find_by(title: "Tamil Nadu")
    @ke = Category.find_by(title: "Kerala")
    @up = Category.find_by(title: "Uttar Pradesh")
    @ma = Category.find_by(title: "Maharashtra")
    @pu = Category.find_by(title: "Punjab")
    @gu = Category.find_by(title: "Gujarat")
    @wb = Category.find_by(title: "West Bengal")

    puts "Created #{categories.count} categories."
  end

  def create_roles
    @lender = Role.create!(name: "lender")
    @borrower = Role.create!(name: "borrower")
    @admin = Role.create!(name: "admin")
    puts "#{@lender.name}, #{@borrower.name}, #{@admin.name} roles created."
  end

  def create_admins
    n = 1
    n.times do |i|
      admin = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name + "#{i}",
        password: Faker::Internet.password,
        bio: Faker::Lorem.paragraph(2),
        image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
      )
      admin.roles << @admin
      puts "#{admin.first_name} #{admin.last_name} created."
    end
    puts "#{n} admins created!"
  end

  def create_borrowers
    n = 20
    n.times do |i|
      borrower = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name + "#{i}",
        password: Faker::Internet.password,
        bio: Faker::Lorem.paragraph(2),
        image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
      )
      borrower.roles << @borrower
      puts "#{borrower.first_name} #{borrower.last_name} created"
    end
    puts "#{n} borrowers created!"
  end

  def create_projects
    project_statuses = ["Pending", "Cancelled", "Active", "Completed"]
    borrowers = Role.find_by(name: "borrower").users
    categories = Category.all
    n = 50
    n.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name + " #{i}",
        description: Faker::Lorem.paragraph,
        image: "http://static.news18.com/pix/2015/05/indian-cow.jpg",
        goal_amount: Random.new.rand(40000..80000),
        user_id: borrowers[Random.new.rand(0..(borrowers.count - 1))].id,
        category_id: @ap.id,
        status: project_statuses[Random.new.rand(0..(project_statuses.count - 1))]
        )
      puts "#{project.title} Project created!"
    end
    n.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name + " #{i}",
        description: Faker::Lorem.paragraph,
        image: "http://static.news18.com/pix/2015/05/indian-cow.jpg",
        goal_amount: Random.new.rand(40000..80000),
        user_id: borrowers[Random.new.rand(0..(borrowers.count - 1))].id,
        category_id: @te.id,
        status: project_statuses[Random.new.rand(0..(project_statuses.count - 1))]
        )
      puts "#{project.title} Project created!"
    end
    n.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name + " #{i}",
        description: Faker::Lorem.paragraph,
        image: "http://static.news18.com/pix/2015/05/indian-cow.jpg",
        goal_amount: Random.new.rand(40000..80000),
        user_id: borrowers[Random.new.rand(0..(borrowers.count - 1))].id,
        category_id: @ka.id,
        status: project_statuses[Random.new.rand(0..(project_statuses.count - 1))]
        )
      puts "#{project.title} Project created!"
    end
    n.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name + " #{i}",
        description: Faker::Lorem.paragraph,
        image: "http://static.news18.com/pix/2015/05/indian-cow.jpg",
        goal_amount: Random.new.rand(40000..80000),
        user_id: borrowers[Random.new.rand(0..(borrowers.count - 1))].id,
        category_id: @tn.id,
        status: project_statuses[Random.new.rand(0..(project_statuses.count - 1))]
        )
      puts "#{project.title} Project created!"
    end
    n.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name + " #{i}",
        description: Faker::Lorem.paragraph,
        image: "http://static.news18.com/pix/2015/05/indian-cow.jpg",
        goal_amount: Random.new.rand(40000..80000),
        user_id: borrowers[Random.new.rand(0..(borrowers.count - 1))].id,
        category_id: @ke.id,
        status: project_statuses[Random.new.rand(0..(project_statuses.count - 1))]
        )
      puts "#{project.title} Project created!"
    end
    n.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name + " #{i}",
        description: Faker::Lorem.paragraph,
        image: "http://static.news18.com/pix/2015/05/indian-cow.jpg",
        goal_amount: Random.new.rand(40000..80000),
        user_id: borrowers[Random.new.rand(0..(borrowers.count - 1))].id,
        category_id: @up.id,
        status: project_statuses[Random.new.rand(0..(project_statuses.count - 1))]
        )
      puts "#{project.title} Project created!"
    end
    n.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name + " #{i}",
        description: Faker::Lorem.paragraph,
        image: "http://static.news18.com/pix/2015/05/indian-cow.jpg",
        goal_amount: Random.new.rand(40000..80000),
        user_id: borrowers[Random.new.rand(0..(borrowers.count - 1))].id,
        category_id: @ma.id,
        status: project_statuses[Random.new.rand(0..(project_statuses.count - 1))]
        )
      puts "#{project.title} Project created!"
    end
    n.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name + " #{i}",
        description: Faker::Lorem.paragraph,
        image: "http://static.news18.com/pix/2015/05/indian-cow.jpg",
        goal_amount: Random.new.rand(40000..80000),
        user_id: borrowers[Random.new.rand(0..(borrowers.count - 1))].id,
        category_id: @pu.id,
        status: project_statuses[Random.new.rand(0..(project_statuses.count - 1))]
        )
      puts "#{project.title} Project created!"
    end
    n.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name + " #{i}",
        description: Faker::Lorem.paragraph,
        image: "http://static.news18.com/pix/2015/05/indian-cow.jpg",
        goal_amount: Random.new.rand(40000..80000),
        user_id: borrowers[Random.new.rand(0..(borrowers.count - 1))].id,
        category_id: @gu.id,
        status: project_statuses[Random.new.rand(0..(project_statuses.count - 1))]
        )
      puts "#{project.title} Project created!"
    end
    n.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name + " #{i}",
        description: Faker::Lorem.paragraph,
        image: "http://static.news18.com/pix/2015/05/indian-cow.jpg",
        goal_amount: Random.new.rand(40000..80000),
        user_id: borrowers[Random.new.rand(0..(borrowers.count - 1))].id,
        category_id: @wb.id,
        status: project_statuses[Random.new.rand(0..(project_statuses.count - 1))]
        )
      puts "#{project.title} Project created!"
    end

    puts "1000 projects created!"
  end

  def create_lenders
    n = 100
    n.times do |i|
      lender = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name + "#{i}",
        password: Faker::Internet.password,
        bio: Faker::Lorem.paragraph(2),
        image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
      )
      lender.roles << @lender
      puts "Lender: #{lender.first_name} #{lender.last_name} created."
    end
    puts "#{n} lenders created!"
  end

  def create_loans
    lenders = Role.find_by(name: "lender").users
    projects = Project.all
    n = 1000
    n.times do |i|
      lender_id = lenders[Random.new.rand(0..(lenders.count - 1))].id
      project_id = projects[Random.new.rand(0..(projects.count - 1))].id
      Loan.create!(user_id: lender_id,
                   amount: Random.new.rand(10..100),
                   project_id: project_id)
    end
    puts "#{n} loans created!"
  end

  def create_sample_accounts
    lender = User.create!(
      first_name: "lender",
      last_name: "lender",
      username: "lender",
      password: "password",
      bio: Faker::Lorem.paragraph(2),
      image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
    )
    lender.roles << @lender
    puts "Created 'lender'"

    borrower = User.create!(
      first_name: "borrower",
      last_name: "borrower",
      username: "borrower",
      password: "password",
      bio: Faker::Lorem.paragraph(2),
      image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
    )
    borrower.roles << @borrower
    puts "Created 'borrower'"

    combined = User.create!(
      first_name: "combined",
      last_name: "combined",
      username: "combined",
      password: "password",
      bio: Faker::Lorem.paragraph(2),
      image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
    )
    combined.roles << @lender
    combined.roles << @borrower
    puts "Created 'combined'"

    admin = User.create!(
      first_name: "admin",
      last_name: "admin",
      username: "admin",
      password: "password",
      bio: Faker::Lorem.paragraph(2),
      image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
    )
    admin.roles << @admin
    puts "Created 'admin'"
    puts "Sample accounts created for lender, borrower, combined and admin. The password is password for each."
  end

  def create_sample_data
    jeff = User.create!(
      first_name: "Jeff",
      last_name: "Casimir",
      username: "jeff@turing.io",
      password: "password",
      bio: "Executive Director of the Turing School of Software & Design, based in Denver, Colorado. I love microfinance.",
      image: "http://frelow.smugmug.com/CodeNewbie/i-8hHRQd7/0/O/jeff.jpg"
    )
    jeff.roles << @lender

    josh = User.create!(
      first_name: "Josh",
      last_name: "Mejia",
      username: "josh@turing.io",
      password: "password",
      bio: "Software Lead and Instructor at the Turing School of Software & Design, based in Denver, Colorado. I also love microfinance.",
      image: "https://pbs.twimg.com/profile_images/548068847677231104/WPu1nCfp.jpeg"
    )
    josh.roles << @lender

    leelavathi = User.create!(
      first_name: "Leelavathi",
      last_name: "Paladugu",
      username: "lpaladugu",
      password: "password",
      bio: "Resident of Mustabada, Andhra Pradesh. Raising money to expand my agricultural business and support my family.",
      image: "http://www2.robertharding.com/preview/RM/RH/VERTICAL/1161-4802.jpg"
    )
    leelavathi.roles << @borrower

    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Carmer",
      username: "andrew@turing.io",
      password: "password",
      bio: "Resident of Jamnagar, Gujarat. Raising money to buy a new rickshaw to support my driving business and by extension my family.",
      image: "http://www.hotboxdenver.com/imgs/ac_linkhead.jpg"
    )
    andrew.roles << @borrower

    gopal = User.create!(
      first_name: "Gopal",
      last_name: "Patel",
      username: "gpatel",
      password: "password",
      bio: "Resident of Jamnagar, Gujarat. Raising money to buy a new rickshaw to support my driving business and by extension my family.",
      image: "http://thumbs.dreamstime.com/x/happy-indian-villager-21530522.jpg"
    )
    gopal.roles << @borrower

    buffalo = leelavathi.projects.create!(
      title: "Buy a Buffalo",
      description: "My family is looking to buy one buffalo, to provide milk for our family and work on our small rice and lentil farm.",
      image: "http://www.releaseinternational.org/wp-content/uploads/2013/05/indian_water_buffalo.jpg",
      goal_amount: 3000,
      user_id: leelavathi.id,
      category_id: Category.all.find_by(title: "Andhra Pradesh").id,
      status: "Active"
      )

    lentils = leelavathi.projects.create!(
      title: "Buy Lentil Seeds",
      description: "My family is looking to buy a large quantity of lentil seed and the associated materials needed to plant five additional acres to farm. We would like to grow excess crops to sell at the nearby city Vijayawada.",
      image: "http://www.crs.org/sites/default/files/crs-files/ind2013077836_0.jpg",
      goal_amount: 1000,
      user_id: leelavathi.id,
      category_id: Category.all.find_by(title: "Andhra Pradesh").id,
      status: "Active"
      )

    rickshaw = andrew.projects.create!(
      title: "Buy a Rickshaw",
      description: "I am looking to buy one rickshaw, to build a driving business in our local city and help my support my family of 12.",
      image: "http://ventureburn.com/wp-content/uploads/2015/04/rickshaw.jpg",
      goal_amount: 2000,
      user_id: andrew.id,
      category_id: Category.all.find_by(title: "Gujarat").id,
      status: "Active"
      )

    buffalo.loans.create( user_id: jeff.id,
                          amount: 2750)
    lentils.loans.create( user_id: josh.id,
                          amount: 650)
    rickshaw.loans.create!(user_id: josh.id,
                          amount: 1500)

    jorge = User.create!(
      first_name: "Jorge",
      last_name: "Téllez",
      username: "jorge@turing.io",
      password: "password",
      bio: "I like to make jokes and boss people around. Father of one.",
      image: "https://pbs.twimg.com/profile_images/545426238173888512/2cfTVpu0.jpeg"
     )
    jorge.roles << @admin

    puts "Sample seed display data created for lenders Jeff and Josh, borrowers Andrew, Leelavathi and Gopal, three projects and admin Jorge."
  end

end

Seed.start
