Program.create!([
  {
    title: "Web Fundamentals",
    identifier: "WF",
    description: "All about the web",
  },
  {
    title: "Underwater Basket Weaving",
    identifier: "UBW",
    description: "Get your SCUBA certification and some nice baskets",
  }
])

Person.create!([
  {
    given_name: "Bob",
    family_name: "Ross",
    full_name: "Bob Ross",
  },
  {
    given_name: "Neil",
    family_name: "Tyson",
    full_name: "Neil deGrasse Tyson",
  }
])

Unit.create([
  {
    title: "C#"
  },
  {
    title: "HTML/JS"
  },
  {
    title: "Capstone"
  }
])

Cohort.create!([
  {
    name: "Cohort I",
    start_date: Date.today,
    end_date: 3.months.from_now,
    program: Program.find_by(identifier: "WF"),
    people: Person.all,
    units: Unit.all,
  },
  {
    name: "Cohort II",
    start_date: 3.months.from_now,
    end_date: 6.months.from_now,
    program: Program.find_by(identifier: "WF"),
  },
  {
    program: Program.find_by(identifier: "WF"),
    start_date: 6.months.from_now,
    end_date: 9.months.from_now,
    name: "Cohort III",
  }
])
