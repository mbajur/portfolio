Rails.application.config.to_prepare do
  Alchemy::Modules.register_module({
    name: 'posts',
    order: 1,
    navigation: {
      name: 'modules.posts',
      controller: '/admin/posts',
      action: 'index',
      # image: 'alchemy/posts_module.png',
      sub_navigation: [{
        name: 'modules.posts',
        controller: '/admin/posts',
        action: 'index'
      }]
    }
  })

  Alchemy.register_ability(PostsAbility)
end
