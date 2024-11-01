# Setup

## Download Repository
When you install [Git](https://git-scm.com/downloads) if already have not,
run clone this repository with
```sh
git clone https://github.com/ernisto/game
```

learn more: [git cloning an existing repository](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository)

## Install Dependencies
Assuming that you already have [Aftman](https://github.com/LPGhatguy/aftman)
installed into your current user,
install all CLI tools, and run our script to install all wally packages with
```sh
aftman install
./scripts/wally-install
```

learn more: [wally](https://github.com/UpliftGames/wally?tab=readme-ov-file#wally-install---locked)

## Configure Mantle Owner
To mantle publish your place, he must to know what is the owner of the place,
if will be your personal account, or a roblox group. So we need setting it into `mantle.yml`.

If you are a solo game developer, is a external contribuitor, or is just testing,
you can just publish in your personal account
```yml
owner: personal
```
Or if this game is a serious project, that you have +1 developers,
or just want to organize game revenue and assets, publish into your group
```yml
owner:
    group: your_group_id
```

learn more: [mantle configuration](https://mantledeploy.vercel.app/docs/configuration/reference#owner)

## Configure Github Environment
So you planning implement a CI/CD workflow, where you will automatically publish
your place when you push some change, you should configure a environment to be
used by github action
- Publish your repository to [Github](https://github.com)
- Go to `Settings` > `Secrets and variables` > `Actions`
- Create the variable:
    - `HUSKY = 0` to disable client git hooks on github server
- Create the secrets:
    - if you are publishing as a group `MANTLE_OPEN_CLOUD_API_KEY` for your
    Open Cloud API Key [Creating a Open Cloud API Key](#creating-a-open-cloud-api-key-link)
    - else if you just publishing as a person, `ROBLOSECURITY` for your personal
    roblox cookie [Getting your ROBLOXSECURITY cookie](#getting-your-robloxsecurity-cookie-link)
    - if you are using Amazon AWS or Cloudflare to store your `mantle-state.yml`,
    create `MANTLE_AWS_ACCESS_KEY_ID` and `MANTLE_AWS_SECRET_ACCESS_KEY`

learn more: [using github secrets](https://docs.github.com/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions)

## Configure Local Environment
If you looking for a local publishment, or you are a external contribuitor,
is recommended you just create a `.env` file in the root of the project,
and add the following variables:
```toml
MANTLE_OPEN_CLOUD_API_KEY="{api key}"

# If u want remote mantle state management
MANTLE_AWS_ACCESS_KEY_ID="{your access key id}"
MANTLE_AWS_SECRET_ACCESS_KEY="{your secret access key}"
```

learn more: [mantle .env files](https://mantledeploy.vercel.app/docs/authentication#dotenv-files)

## Configure Remote State Settings
For both the cases, you should update this part too
- if you want manage your mantle states remotelly (through Amazon AWS or Cloud Flare)
you must to fill those infos with your bucket infos
- otherwise you want manage them locally, just remote it
```yml
state:
  remote:
    region: # if is Amazon AWS, just the region
      custom: # if is Cloud Flare
        name: ENAM # Bucket Location
        endpoint: https://dc88f586de4d2c1eb08099d9e049613e.r2.cloudflarestorage.com # Bucket API S3
    bucket: starled-games-mantle-states # Bucket Name
    key: template # Prefix of .mantle-state.yml, tipically your project name
```

learn more: [setuping remote states](https://mantledeploy.vercel.app/docs/remote-state)

# Useful infos

## Creating a Open Cloud API Key [🔗](#creating-a-open-cloud-api-key-link)
To mantle be able to publish ur place in your account/group,
you should to create a Open Cloud API Key to be used by mantle

- Navigate to the [Creator Dashboard](https://create.roblox.com/dashboard/creations).
- Click the `Creator Hub` dropdown to select a group if you are creating the API key for a group.
- In the left navigation menu, select `Open Cloud` > `API Keys`.
- Click the `Create API Key` button.
- Enter a unique name for your API key. Such as `MANTLE PUBLISHING API`.
- In the `Access Permissions` section, select an `API System` from the `Select API System`
menu and click the `Add API System` button
- Select the experience that you want to access with the API key.
- From the `Experience Operations` dropdown, select the the operation.

Mantle will requires the following `Operations` from the determinated `API Systems`
- assets
    - asset:read
    - asset:write
- universe-places
    - universe-places:write
- universe
    - universe:write
    - universe.place:write
- notifications
    - user.user-notifications:write

learn more: [roblox open cloud api](https://create.roblox.com/docs/cloud/open-cloud/api-keys) and [mantle authentication](https://mantledeploy.vercel.app/docs/authentication#roblox-open-cloud-api-key)

## Getting your ROBLOXSECURITY cookie [🔗](#getting-your-robloxsecurity-cookie-link)
- Navigate to [roblox](https://roblox.com/) in your browser and open the
`dev tools` (right-click and select `Inspect`).
- Navigate to the `Application` tab, then look for `Cookies` under `Storage` in
the left-hand sidebar.
- Under `Cookies`, select `https://www.roblox.com` then select `.ROBLOSECURITY`
from the list of cookies.
- Copy the value from the `Cookie Value` section.

If there is a logged-in `Roblox Studio` installation, Mantle can automatically
extract its `.ROBLOSECURITY`
cookie and will authenticate requests as the user logged in to Roblox Studio.

learn more: [mantle roblox security](https://mantledeploy.vercel.app/docs/authentication#roblosecurity)