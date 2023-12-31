projectiles = {}

function create_bullet(source_x, source_y, target_x, target_y)
    return create_projectile(1, 5, source_x, source_y, target_x, target_y)
end

function create_projectile(speed, sprite, source_x, source_y, target_x, target_y)
    local projectile = {
        x=source_x,
        y=source_y,
        speed=speed,
        rise_run=calc_unit_vector(source_x, source_y, target_x, target_y),
        sp=sprite
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