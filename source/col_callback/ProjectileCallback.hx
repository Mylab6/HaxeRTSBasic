package col_callback;

import entities.BaseBox;
import entities.EnemyBox;
import entities.Projectile;
import flixel.FlxSprite;

class ProjectileCallback
{
	public static function onProjectileHitEnemy(box:FlxSprite, projectile:FlxSprite):Void
	{
		var projectileF = cast(projectile, Projectile);
		if (projectileF.EnemyProjectile)
		{
			return;
		}
		var enemyBox = cast(box, EnemyBox);
		enemyBox.TakeDamage(projectileF.Damage);
		projectile.kill();
	}

	public static function onProjectileHitBox(box:FlxSprite, projectile:FlxSprite):Void
	{
		var projectileF = cast(projectile, Projectile);
		if (!projectileF.EnemyProjectile)
		{
			return;
		}
		var pos = projectileF.getPosition();
		var baseBox = cast(box, BaseBox);
		baseBox.hit(projectileF.Damage, pos.x, pos.y);
		projectile.kill();
	}
}