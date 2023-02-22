# `bookmarks`

![](https://img.shields.io/github/v/release/cadnza/bookmarks)

Sweet and simple bookmarks manager.

## What it is

It's a simple command line utility that organizes your web bookmarks into `$HOME/.bookmarks`, which you can symlink from Dropbox, a Git repo, or anywhere else.

## What it's for

Syncing your bookmarks into a text file is simpler and more straight-forward that going through any of the major browsers. And if you're like me, you're only ever opening your bookmarks through [Alfred](https://www.alfredapp.com/) anyway, so you hardly need them attached to your browser.

`bookmarks` is fully featured with intuitive shell completions for bash, zsh, and fish, so it works great on the command line, but it's primarily intended as a backend utility for UI applications like [my Alfred extension](https://github.com/cadnza/Alfred.alfredpreferences/blob/master/exports/com.cadnza.alfredBookmarks.alfredworkflow).

## Installation

Build with `swift build`.

## Use

A single bookmark is comprised of a title, a URL, and an optional tag. `bookmarks` comes with four base commands for manipulating those attributes as well as two convenience commands:

### Base commands

#### `bookmarks add`

Adds a new bookmark.

#### `bookmarks remove`

Removes a bookmark.

#### `bookmarks update`

Updates one or more attributes of a bookmark.

#### `bookmarks list`

Lists all bookmarks in either pretty or JSON format.

### Convenience commands

#### `bookmarks update-tag`

Updates a tag on all bookmarks that contain it.

#### `bookmarks list-tags`

Lists all tags.

#### Why convenience commands?

Strictly speaking, you can perform any manipulation you'd like using `bookmark`'s base commands. The convenience commands make interfacing with `bookmark` a little friendlier, though.

For example, the following will change the name of a tag on all of its bookmarks using only base commands:

```zsh
#!/usr/bin/env zsh

oldTag="Projects"
newTag="Things to do"

containsTag=1
while [ $containsTag = 1 ]
do
	idToUpdate=$(bookmarks list -j | jq -r ".[] | select(.tag==\"$oldTag\") | .id" | head -n 1)
	bookmarks update $idToUpdate -t $newTag
	containsTag=0
	bookmarks list -j | jq -r '[.[].tag] | unique | .[] | select (. != null)' | \
	while read -r tag
	do
		[[ $tag = $oldTag ]] && containsTag=1
	done
done
```

That operation is more performant and dramatically simpler with the convenience command `update-tag`:

```zsh
bookmarks update-tag "Projects" "Things to do"
```

## Questions

The rest of `bookmarks`'s documentation lives in its help menus; give it a download to get started.

Happy bookmarking!
