# Corentin Hervaud portfolio

This is my personal website, build using [NuxtJS](https://nuxt.com/) with [Typescript](https://www.typescriptlang.org/) and hosted on [GitLab pages](https://docs.gitlab.com/ee/user/project/pages/).

This repository comes from [this GitLab repository](https://gitlab.com/corthx/portfolio), if you're seeing this through another platform, this is probably a mirroring.

[[_TOC_]]

## My links

- [My LinkedIn profile](https://www.linkedin.com/in/corentin-hervaud/)
- [My GitHub profile](https://github.com/Curs3W4ll)
- [My GitLab profile](https://gitlab.com/corthx)

## Project details

### Technical stack

The project is using [NuxtJS](https://nuxt.com/) with [Typescript](https://www.typescriptlang.org/) as a main framework.  
The project is then generated as a JamStack static website and hosted on [GitLab pages](https://docs.gitlab.com/ee/user/project/pages/).

The project is using [ESLint](https://eslint.org/) for linting and good practices tracking.  
The project is using [Prettier](https://prettier.io/) for code formatting.

The project is using [Tailwindcss v4](https://tailwindcss.com/) as css library.  
The project is using [VoltUI](https://volt.primevue.org/) as components library.  
The project is using [Unleash](https://www.getunleash.io/) as feature flag library.  
The project is using [Sentry](https://sentry.io/) as error management tool.  
The project is using [Storyblok](https://www.storyblok.com/) headless CMS for content management.

#### Installation

The toolchain is pinned in `mise.toml`, so the only prerequisite is
[mise](https://mise.jdx.dev/) itself:

- Install the `mise` CLI
- Run the following command in the project folder:

```sh
mise trust
```

Entering the folder then installs the pinned tools and sets up the [Git hooks](#git-hooks) automatically. Everything
else is a regular npm project:

- Install dependencies with `npm install`
- See a list of available commands with `npm run`, and of mise tasks with `mise tasks`

If you wish to start the project either in `dev` mode or in `preview` mode with Storyblok working, you will need to create a local ssl certificate.  
In order to do this, follow these steps:

- Install the `mkcert` CLI
- Run the following command in the project folder:

```sh
mkcert localhost
```

- You're ready to locally launch the project in https!

#### Project deployment

The project is currently deployed on GitLab pages using GitLab CI.  
If you wish to deploy the project by another way, you could follow these steps:

- Create a `.env` file following the `.env.example` file structure. Here is a detailed explanation of each env variable:

| Variable                         | Type                   | Description                                                                      |
| -------------------------------- | ---------------------- | -------------------------------------------------------------------------------- |
| `NUXT_PUBLIC_SENTRY_DSN`         | `String`, `undefined`  | The DSN to use to connect to a Sentry project                                    |
| `NUXT_PUBLIC_MODE`               | `String`               | The mode the website is deployed for (`development`, `staging`, `production`...) |
| `NUXT_PUBLIC_VERSION`            | `String`               | The version of the website deployed                                              |
| `NUXT_PUBLIC_GTAG_ID`            | `String`, `undefined`  | The Id to use to connect to Google Analytics                                     |
| `NUXT_STORYBLOK_ACCESS_TOKEN`    | `String`, `undefined`  | The access token used to connect to the StoryBlok space                          |
| `NUXT_STORYBLOK_VERSION`         | `String`, `undefined`  | The version used when getting StoryBlok stories                                  |
| `NUXT_UNLEASH_PROXY_URL`         | `String`, `undefined`  | The URL of the Unleash proxy to use                                              |
| `NUXT_UNLEASH_PROXY_CLIENT_KEY`  | `String`, `undefined`  | The client key to use when connecting to the Unleash proxy                       |
| `NUXT_KEEP_DATA_TEST_ATTRIBUTES` | `Boolean`, `undefined` | Whether to keep the `data-test` attributes or no                                 |
| `NUXT_BASE_URL`                  | `String`               | The base URL used by i18n                                                        |

- Option 1: Run the website as a **static website** (used for GitLab pages deployment)
  - Generate a static version of the website with `npm run generate`
  - Deploy the static website using the tool you want or with `npx serve .output/public` for example
- Option 2: Run the website as a **SPA**
  - Build the website with `npm run build`
  - Serve the website using the tool you want

#### Update StoryBlok types

This project is using [StoryBlok](https://www.storyblok.com) to retrieve its content from a headless CSM.

StoryBlok is used acrosse the project to retrieve data, and as the project is using Typescript, we need a way to type the data returned by the CSM.  
In order to do this, we're using the StoryBlok CLI to generate schemas used for typing.

To update the types according to the architecture used in the StoryBlok space, follow these steps:

- Ensure you're logged in using `npm run storyblok:login`
- Update generated types using `npm run storyblok:updatetypes`

#### Git hooks

The hooks below are managed by [pre-commit](https://pre-commit.com/) (see `.pre-commit-config.yaml`); the ones that
are not off-the-shelf tools live in `.gitlab/git-hooks/`. They are installed for you when you enter the project
folder, or by hand with `mise run pre-commit:setup`.

##### Issue id auto-filler

This custom Git hook allow to write your commit without the issue id, as it will automatically insert it at the start of a commit (if not already present, avoiding duplications), so you don't have to.  
Both committing using `git commit -m` and `git commit` editor are supported.

##### Commit checker

This custom Git hook will check every commit you do, and ensure that it is following [our convention](#commit-convention). If a commit does not match the convention, it will be aborted.

##### Branch name checker

This custom Git hook will check every branch you're trying to push to, and ensure that it is following [our convention](#branch-naming-convention). If the branch name does not match the convention, the push will be aborted.

##### Merge request link generator

This custom Git hook will display a link to quickly create a well-configured merge request each time your are pushing to a branch.

##### Formatter and linter

This Git hook runs [Prettier](https://prettier.io/), [ESLint](https://eslint.org/),
[yamllint](https://yamllint.readthedocs.io/), [markdownlint](https://github.com/DavidAnson/markdownlint) and
[ShellCheck](https://www.shellcheck.net/) on the staged files before committing, so files are automatically formatted
and obvious mistakes are caught before they reach a merge request. A hook that rewrites a file fails the commit and
leaves the change unstaged, so you can review it before committing again.

### Conventions

This repository is following a bunch of conventions to have a uniform code base.

#### Commit convention

To keep the commit history easy to read, commits must be clear and detailed.  
Please read [Atomic commits](#atomic-commits) first.

Commits should follow the following format:

```text
#<issue-id> :<gitmoji>: [<scope>] <description>
<body>
```

- `<issue-id>`: The GitLab issue id this branch is linked to. The issue id is a number
- `<gitmoji>`: The Gitmoji to label your commit, see [Gitmojies](https://gitmoji.dev)
- `<scope>`: **[Optional, Encouraged]** The scope this commit's changes acts on (Login page, Button component, Database service…). This should not be more than two words.
- `<description>`: A short description of the work contained in the commit. This description should be at least 10 characters long. Here is a little tip to know what to put as a description: Complete this phrase: If merged, this commit will... and here it is, you have a description! (don’t put the start of the phrase into your commit).
- `<body>`: **[Optional]** Additional information, this could be links, text, requests…

##### Examples

```text
#234 :bug: [Bed card] Fix wrong patient lastname displayed
```

```text
#234 :sparkles: [Database service] Secure connection to the database
Following the jinja connection conventions: https://myinsanewebsite.com/wouhou
```

```text
#234 :pencil: [Readme] Explain how to use Ansible
```

```text
#234 :art: Format code
```

```text
#234 :wrench: Export compile_commands.json file when building project
```

#### Atomic commits

Your commits should be atomics (more information about what is an atomic commit in the [Promyze webinar](https://www.youtube.com/watch?v=4eUeEQe2GJk)).

Atomic commits allow others to easily read what your commits are doing.

The goal is to isolate as many as possible changes you do. You should commit your changes step by step (not a big solo commit).

Another important rule of atomic commits is to be functional and isolated. This means that it should be possible to revert any commit without affecting the other and without breaking the build.  
For example, you should push everything related to the code you are committing. You will not commit the code, then the tests, then the documentation but all at the same time. Everything that is linked should (and must) be in the same commit. But you should split your commits as much as possible so they are readable.  
Your commits change should not be hard to read.

#### Branch naming convention

To keep branches readable, you must name the branch you create according to the following format:

```text
<issue-id>-<issue-summary>
```

- `<issue-id>`: The GitLab issue id this branch is linked to. The issue id should is a number
- `<issue-summary>`: The summary of the GitLab issue, replacing spaces with `-`.

The branches you create should always take the source into the `main` branch.

##### Examples

```text
234-Setup-conventions
```

```text
24-Add-login-button
```

#### Code conventions

The code produced for this project is following a bunch of conventions to keep it uniform:

1. [VueJS style guide](https://vuejs.org/style-guide/)
