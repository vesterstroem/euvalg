import { test, expect, Locator } from '@playwright/test';
import { assert } from 'console';
import { allowedNodeEnvironmentFlags } from 'process';

const fs = require('fs')

test('run', async ({ page }) => {
  var allOutput = "";

  await page.goto('https://www.dr.dk/nyheder/politik/ep-valg/din-stemmeseddel');


  // drcc-button submitAll
  await page.getByText("TILLAD ALLE").click();


  // AccordionGrid_link__TM_R5
  const elements = page.getByTestId("AccordionGrid_link__TM_R5");
  await elements.first().waitFor();

  const candidates = await elements.all()

  console.log("candidates: " + candidates.length);

  const start = 160
  for (const candidate of candidates.slice(start, start + 10)) {
    await candidate.click();
    const candidateName = await candidate.textContent()

    await page.getByText("VIS ALLE").click();

    const answers = await page.locator('xpath=//div[contains(@class,"candidateAnswer")]/following-sibling::label').all();

    for (const answer of answers) {
      const answerValue = await answer.getAttribute('for')
      const data = candidateName + ", " + answerValue;
      console.log(data);
      allOutput += data + "\n";

    }

    await new Promise(r => setTimeout(r, 1000));

    await page.goBack();
  }

  fs.writeFile('Output' + start + '.txt', allOutput, (err) => {
    if (err) throw err;
  })

});

