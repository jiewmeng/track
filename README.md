# TRACK (An Expences App)

[Trello Board][trello-board]

A simple app to track daily expences. 

- Track your expences
    + Categorize
    + Plot data [ChartJS][chartjs]
        * Daily/monthly
        * Different categories (eg. Food vs Transport vs Clothes ...)
    + Take photo? [HTML5 Camera][html5-camera]
- Works on Web & Mobile (Responsive web app)
- Saves/syncs data to Dropbox
- Hosted as GitHub Pages
- Works offline? 

## Developer Guide

- The entry point for CoffeeScript (or JS later) is `app.coffee`. It will include RequireJS config
- All application styles should in included/imported by `app.styl`
- Then the concatinated version (with libraries) will be suffixed with `-all`. eg. `app-all.js`
- Minified version will have .min suffixed eg. `app-all.min.js`

### Folder Structure

- `/src`: source files
- `/src/assets`: files directly copied to distribution (libraries etc)
- `/src/coffee`: coffee script files (compiled and concatinated by r.js into `/dist/js/app.js`)
- `/src/jade`: jade files (compiled into `/dist`)
- `/src/stylus`: stylus files (compiled into `/dist/css/app.css`)
- `/tests`: test files
- `/dist`: distribution dir

### GRUNT tasks

#### Basic stuff

1. Copy assets into dist
2. Copy bower components into respective dist folders (`dist/{css,js}`)
3. Compile CoffeeScript into `dist/js`
4. Compile Stylus into dist `dist/css`
5. Compile Jade into dist `dist/`
6. Concat (r.js) CoffeeScript into app-all.js (remove tmp CoffeeScript files?)
7. Concat compiled stylus file with vendor CSS (eg. Bootstrap etc, then remove temp files?)

- Watch, compile and LiveReload

[html5-camera]: http://www.html5rocks.com/en/tutorials/getusermedia/intro/
[chartjs]: http://www.chartjs.org/docs/
[trello-board]: https://trello.com/b/YMzUaIhh/track-expences-app