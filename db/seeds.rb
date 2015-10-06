Action = Category.create( name: 'Action') unless Category.find_by(name: 'Action')

Action.children.create( name: 'Ball and Paddle' ) unless Category.find_by(name: 'Ball and Paddle')
Action.children.create( name: 'Fighting' ) unless Category.find_by(name: 'Fighting')
Action.children.create( name: 'MOBA=Multiplayer Online Battle Arena' ) unless Category.find_by(name: 'MOBA=Multiplayer Online Battle Arena')
Action.children.create( name: 'Pinball' ) unless Category.find_by(name: 'Pinball')
Action.children.create( name: 'Survival Horror' ) unless Category.find_by(name: 'Survival Horror')



Shooter = Category.create( name: 'Shooter') unless Category.find_by(name: 'Shooter')

Shooter.children.create( name: 'First-person shooter' ) unless Category.find_by(name: 'First-person shooter')
Shooter.children.create( name: 'Rail shooter' ) unless Category.find_by(name: 'Rail shooter')
Shooter.children.create( name: 'Third-person shooter' ) unless Category.find_by(name: 'Third-person shooter')



Adventure = Category.create( name: 'Adventure') unless Category.find_by(name: 'Adventure')

Adventure.children.create( name: 'Real-time 3D' ) unless Category.find_by(name: 'Real-time 3D')
Adventure.children.create( name: 'Graphic adventures' ) unless Category.find_by(name: 'Graphic adventures')
Adventure.children.create( name: 'Interactive movie' ) unless Category.find_by(name: 'Interactive movie')



RPG = Category.create( name: 'RPG') unless Category.find_by(name: 'RPG')

RPG.children.create( name: 'Fantasy RPGs' ) unless Category.find_by(name: 'Fantasy RPGs')
RPG.children.create( name: 'Action RPGs' ) unless Category.find_by(name: 'Action RPGs')
RPG.children.create( name: 'MMORPGs' ) unless Category.find_by(name: 'MMORPGs')
RPG.children.create( name: 'Tactical RPGs' ) unless Category.find_by(name: 'Tactical RPGs')



Simulation = Category.create( name: 'Simulation') unless Category.find_by(name: 'Simulation')

Simulation.children.create( name: 'Construction and management' ) unless Category.find_by(name: 'Construction and management')
Simulation.children.create( name: 'Life simulation' ) unless Category.find_by(name: 'Life simulation')
Simulation.children.create( name: 'Vehicle simulation' ) unless Category.find_by(name: 'Vehicle simulation')



Strategy = Category.create( name: 'Strategy') unless Category.find_by(name: 'Strategy')

Strategy.children.create( name: 'War game' ) unless Category.find_by(name: 'War game')
Strategy.children.create( name: 'Real-time strategy' ) unless Category.find_by(name: 'Real-time strategy')
Strategy.children.create( name: 'Tower defense' ) unless Category.find_by(name: 'Tower defense')



Sports = Category.create( name: 'Sports') unless Category.find_by(name: 'Sports')

Sports.children.create( name: 'Racing' ) unless Category.find_by(name: 'Racing')
Sports.children.create( name: 'Sports game' ) unless Category.find_by(name: 'Sports game')



Others = Category.create( name: 'Others') unless Category.find_by(name: 'Others')
