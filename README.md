# nginxcfg-wordpress-meteor
A Basic Nginx Config File for Wordpress + Meteor.js Support

I just wanted to share this nginx config file in the hopes that it may save some frustration for someone else in a similar scenario.

<h2>When to Use</h2>

If you have already deployed a meteor app using a service like mup, and want to add Wordpress (or other content) and serve the files correctly using nginx.

<h2>Basic Idea</h2>

The first block is courtesy of <a href="http://stackoverflow.com/a/27101114/4072377">this stackoverflow answer</a>. Basically, save some bandwidth if there isn't anything to serve.

The second block is where most of the work happens. If nginx sees /blog/ or /blog (courtesy of the '(.*)$' tag after /blog/) it's going to redirect to the content in our /var/www/example.com/ folder.

*Note that the content actually resides at /var/www/example.com/blog/ -- nginx tacks on the subfolder within the construct of the location.

The try_files line is necessary for how Wordpress and pretty permalinks work. Without it, you may be able to still get away with the traditional example.com/?p=12 format.

Finally, tucking the '~ \.php$' inside of the /blog/ location ensures that these rules are going to apply to Wordpress only. This config assumes you are using php5-fpm. fastcgi_pass may vary depending on your php setup.

For everything else, nginx proxy passes to localhost:3001, our meteor deployment.

<h2>YMMV</h2>

This config is working for me as is, but I'm no nginx expert. Just hacked together a few ideas into a config that is working for my specific scenario.

Good luck!
