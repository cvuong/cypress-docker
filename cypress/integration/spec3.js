describe('test suite 3', () => {
  const xhrData = [];

  after(() => {
    cy.log('xhr data', xhrData);
    const path = './cypress/xhr/xhr.json';
    cy.writeFile(path, xhrData);
  });

  it('this is a test', () => {
    cy.log('supp');
    cy.server({
      onResponse: (response) => {
        const url = response.url;
        const method = response.method;
        const data = response.response.body
        xhrData.push({ url, method, data });
      }
    });
    cy.route({
      method: 'POST',
      url: '*',
    });
    cy.route({
      method: 'GET',
      url: '*',
    });
    cy.visit('/');
    cy.get('#test');
  });


})
