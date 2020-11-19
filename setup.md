• Explicar os models, associações e controllers de Garden e Plants
• Mostrar as rotas iniciais

• Gerar o Model de Tags:
`rails g model Tag name`

• Fazer o Seed das Tags:
```
Tag.create!(
  name: "Frutifera"
)

Tag.create!(
  name: "Carnívora"
)

Tag.create!(
  name: "Religiosa"
)
```

• Fazer model da join_table (plant_tag):
`rails g model plant_tag plant:references tag:references`

• Atualizar associações dos modelos pré-existentes:
**plant.rb**
```
has_many :plant_tags, dependent: :destroy
has_many :tags, through: :plant_tags
```

**tag.rb**
```
has_many :plant_tags, dependent: :destroy
has_many :plants, through: :plant_tags
```

• Criar o controller para o model Plant_tag:
`rails g controller plant_tags`

• Atualizar o routes.rb:
```
  resources :plants, only: [] do
    resources :plant_tags, only: [ :new, :create ]
  end
```

• Criar uma view p/ adicionar as tags:
*app/views/plant_tags/new.html.erb*
```
<div class="container">
  <h1>Add tag for <%= @plant.name %></h1>
  <%= simple_form_for [@plant, @plant_tag] do |f|%>
    <%= f.input :tag, collection: Tag.all, input_html: { multiple: true, class: "multiple-select mb-2" }, include_hidden: false %>
    <%= f.submit "Add Tag", class: "btn btn-primary"%>
  <% end %>
</div>
```

• Criar as Actions do Controller Plant_tags
```
 def new
   @plant = Plant.find(params[:plant_id])
   @plant_tag = PlantTag.new
 end
 
 def create
   @plant = Plant.find(params[:plant_tag])
   @tag = Tag.find(params[:plant_tag][:tag])
   plant_tag = PlantTag.new
   plant_tag.plant = @plant
   plant_tag.tag = @tag
   plant_tag.save
   redirect_to garden_path(@plant.garden)
 end
```
*Testar código*


• Seed no banco de dados
```
Garden.destroy_all if Rails.env.development?

little = Garden.create!(
  name: "My Little Garden",
  banner_url: "https://raw.githubusercontent.com/lewagon/fullstack-images/master/rails/parks-and-plants/garden_1.jpg"
)

other = Garden.create!(
  name: "My Other Garden",
  banner_url: "https://raw.githubusercontent.com/lewagon/fullstack-images/master/rails/parks-and-plants/garden_2.jpg"
)

Plant.create!(
  name: "Monstera",
  image_url: "https://raw.githubusercontent.com/lewagon/fullstack-images/master/rails/parks-and-plants/plants/monstera.jpg",
  garden: little
)

Plant.create!(
  name: "Philo",
  image_url: "https://raw.githubusercontent.com/lewagon/fullstack-images/master/rails/parks-and-plants/plants/philo.jpg",
  garden: little
)

Plant.create!(
  name: "Dieff",
  image_url: "https://raw.githubusercontent.com/lewagon/fullstack-images/master/rails/parks-and-plants/plants/dieffenbachia.jpg",
  garden: other
)
```
