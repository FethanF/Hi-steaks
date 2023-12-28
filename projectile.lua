projectiles = {}

function create_projectile(source_x, source_y, target_x, target_y)
    local projectile = {
        x=0,
        y=0,
        speed=1,
        rise_run=calc_unit_vector(source_x, source_y, target_x, target_y),
        sp=05
    }
    add(projectiles, projectile)
    return projectile
end

function update_projectile(projectile)
    projectile.y+=projectile.rise_run.rise*projectile.speed
    projectile.x+=projectile.rise_run.run*projectile.speed

    -- delete projectile if its out of screen--
    if projectile.x>=128 or projectile.x<=0 or projectile.y<=0 then
        delete_projectile(projectile)
    end

    --checks if the projectile is in the players collider
    local is_in_player_collider = player.check_if_collider_hit(player, projectile.x, projectile.y)
    if is_in_player_collider then
        delete_projectile(projectile)
        player.health -= 1
    end
end

function delete_projectile(projectile)
	del(projectiles, projectile)
end