package PluginInstaller::Plugin;

use strict;
use Git::Wrapper;

sub xfrm_cfg_plugin {
    my ($cb, $app, $param, $tmpl) = @_;
    my $node = $tmpl->getElementById('useful-links')
        or return $app->error('cannot get the useful links block');
    my $html = $node->innerHTML();
    my $li = '<li><a href="javascript:void(0)" onclick="openDialog(null,\'install_plugin_start\'); return false;">Install Plugin from Git</a></li>';
    $html =~ s/<\/ul>/$li<\/ul>/m;
    $node->innerHTML($html);
    $param;
}

sub do_install {
    my $app = shift;
    my $q       = $app->{query};
    my $repos = File::Spec->catfile( $app->config('StaticFilePath'), 'support', 'installed-plugins' );

    MT->log("Setting up git in $repos");

    if (!-d $repos) {
        my $fmgr = MT::FileMgr->new('Local')
            or return $app->error( MT::FileMgr->errstr );
        MT->log("Git repos '$repos' does not exist. Creating it.");
        $fmgr->mkpath($repos)
            or return $app->error( "Could not create $repos: " . MT::FileMgr->errstr );
    }

    my $git = Git::Wrapper->new($repos);
    my $url = $q->param('git-url');
    MT->log("Installing plugin from $url");
    $git->clone( $url );

    return $app->load_tmpl( 'dialog/close.tmpl' );
}

sub install_dialog {
    my $app = shift;
    my ($param) = @_;
    my $q       = $app->{query};

    $param ||= {};

    #$param->{screen_id}  = 'edit-prototype';
    return $app->load_tmpl( 'dialog/start.tmpl', $param );
}

1;
__END__
