package DDG::Goodie::MarkdownCheatSheet;
# ABSTRACT: Provide a cheatsheet for common Markdown syntax

use DDG::Goodie;

zci answer_type => "markdown_cheat";
zci is_cached   => 1;

name "MarkdownCheatSheet";
description "Markdown cheat sheet";
source "http://daringfireball.net/projects/markdown/syntax";
code_url "https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/MarkdownCheatSheet.pm";
category "cheat_sheets";
topics "computing", "geek", "web_design";

primary_example_queries 'markdown help', 'markdown cheat sheet', 'markdown syntax';
secondary_example_queries 'markdown quick reference', 'markdown guide';

triggers startend => (
    'markdown', 'md',
    'markdown help', 'md help',
    'markdown cheat sheet', 'md cheat sheet',
    'markdown cheatsheet', 'md cheatsheet',
    'markdown syntax', 'md syntax',
    'markdown guide', 'md guide',
    'markdown quick reference', 'md quick reference',
    'markdown reference', 'md reference',
);

attribution github  => ["marianosimone", "Mariano Simone"];

# Base snippet definitions
my %snippets = (
    'header' => {
        'html' => '<h1>This is an H1</h1><h2>This is an H2</h2><h6>This is an H6</h6>',
        'text' => '# This is an H1
## This is an H2
###### This is an H6'
    },
    'em' => {
        'html' => '<em>Emphasis</em> or <em>ephasis</em>',
        'text' => '_emphasis_ or *emphasis*'
    },
    'strong' => {
        'html' => '<strong>Strong</strong> or <strong>strong</strong>',
        'text' => '**strong** or __strong__'
    },
    'list' => {
        'html' => '<ul><li>First</li><li>Second</li><li>Third</li></ul><ol><li>First</li><li>Second</li><li>Third</li></ol>',
        'text' => '- First
- Second
- Third

1. First
2. Second
3. Third'
    },
    'image' => {
        'html' => '<img src="http://duckduckgo.com/assets/badges/logo_square.64.png"></img>',
        'text' => '![Image Alt](http://duckduckgo.com/assets/badges/logo_square.64.png)'
    },
    'link' => {
        'html' => '<a href="http://www.duckduckgo.com" title="Example Title">This is an example inline link</a>',
        'text' => '[This is an example inline link](http://www.duckduckgo.com "Example Title")'
    },
    'blockquote' => {
        'html' => '<blockquote>This is the first level of quoting.<blockquote>This is nested blockquote.</blockquote>Back to the first level.</blockquote>',
        'text' => '> This is the first level of quoting.
>
> > This is nested blockquote.
>
> Back to the first level.'
    }    
);

my %synonyms = (
    "header", ['h1', 'headers', 'h2', 'h3', 'h4', 'h5', 'h6', 'heading'],
    "em", ['emphasis', 'emphasize'],
    "strong", [],
    "image", ["img", "images", "insert image"],
    "link", ["a", "href", "links"],
    "blockquote", ["quote", "quotation"],
    "list", ["lists", "ordered list", "unordered list", "ul", "ol"]
);

# Add more mappings for each snippet
foreach my $key (keys(%synonyms)) {
    foreach my $v (@{$synonyms{$key}}) {
        $snippets{$v} = $snippets{$key};
    }
}

my $more_at = '<a href="http://daringfireball.net/projects/markdown/syntax" class="zci__more-at--info"><img src="//images.duckduckgo.com/iu/?u=http%3A%2F%2Fdaringfireball.net%2Ffavicon.ico" class="zci__more-at__icon"/>More at Daring Fireball</a>';

sub make_html {
    my $element = $_[0];
    return $snippets{$element}->{'html'}.'<pre>'.$snippets{$element}->{'text'}.'</pre>'.$more_at
};

handle remainder => sub {
    return unless $_;
    my $requested = $snippets{$_};
    return unless $requested;
    return
        heading => 'Markdown Cheat Sheet',
        html    => make_html($_),
        answer  => $snippets{$_}->{'text'}
};

1;
