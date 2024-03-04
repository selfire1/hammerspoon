#!/usr/bin/env zx
import appConfig from "./config.js";

// arguments
const thisFocus = argv?.focus ? argv.focus.toLowerCase() : "default";
const CONFIG = appConfig[thisFocus];

// run
await hideAllApps();
const appArray = getNamesOfApps();
await activateApps(appArray);
await setDisplaysToLayouts();
await moveAppsToDisplays().then(async () => {
  await activateFocusApp();
});

// methods
async function ym(arg) {
  return await $`yabai -m ${arg.split(" ")}`;
}

async function hideAllApps() {
  await $`osascript -e 'tell application "System Events" to set visible of every process whose visible is true to false'`;
}

async function activateApps(appNames) {
  appNames.forEach(async (app) => {
    await activateApp(app);
  });
}

async function getAppWindowId(app) {
  const output =
    await $`yabai -m query --windows | jq '.[] | select(.app == "${app}").id'`;
  return output.stdout.trim().replaceAll("\n", "");
}

async function setSpacesToLayout(allSpaces, index, layout) {
  const displayIdx = index + 1;
  const spaces = allSpaces.filter((el) => el.index === displayIdx);
  spaces.forEach(async (el) => {
    await ym(`space ${el.index} --layout ${layout}`);
  });
}

async function moveWindowToFirstSplit(windowId, spaceIdx) {
  const spaces = await getSpaces();
  const space = spaces.find((el) => el.index === spaceIdx);
  const firstWindowId = space["first-window"].toString();
  if (windowId === firstWindowId.toString()) {
    return;
  }
  if (!+firstWindowId) {
    console.info("firstWindowId is 0");
    return;
  }
  try {
    await ym(`window ${windowId} --swap ${firstWindowId}`);
  } catch (error) {
    console.info({ windowId, firstWindowId });
    console.warn(error);
  }
}

async function moveAppsToDisplays() {
  await CONFIG.forEach(async (display, idx) => {
    const appsOnThisDisplay = display.apps;
    const displayIndex = idx + 1;
    await moveAppsToDisplay(appsOnThisDisplay, displayIndex);
    const firstApp = appsOnThisDisplay[0].name;
    if (display.layout == "bsp") {
      const id = await getAppWindowId(firstApp);
      await moveWindowToFirstSplit(id, displayIndex);
    } else if (display.layout === "stack") {
      await activateApp(firstApp);
    }
  });
}

async function activateApp(app) {
  await $`osascript -e 'tell application "${app}" to activate'`;
}

async function setDisplaysToLayouts() {
  const spaces = await getSpaces();
  CONFIG.forEach(async (el, idx) => {
    await setSpacesToLayout(spaces, idx, el.layout);
  });
}

function getNamesOfApps() {
  return CONFIG.map((el) => el.apps.map((el) => el.name)).flat();
}

async function getSpaces() {
  const spacesRaw = await ym("query --spaces");
  const spaces = JSON.parse(spacesRaw);
  return spaces;
}

async function moveAppsToDisplay(apps, displayIndex) {
  await apps.forEach(async (el) => {
    const id = await getAppWindowId(el.name);
    await ym(`window ${id} --display ${displayIndex}`);
  });
}

async function activateFocusApp() {
  const focusApp = CONFIG.map((el) => el.apps)
    .flat()
    .find((el) => el.focus).name;
  await activateApp(focusApp);
}
