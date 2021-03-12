context("Test students list page content", () => {
  describe("For a single student", () => {
    beforeEach(() => {
      cy.app("clean");
      cy.appFactories([
        [
          "create",
          "student",
          {
            id: 1,
            email: "john@example.com",
            title: null,
            first_name: "John",
            last_name: "Smith",
            middle_name: null,
            birth_date: "2011/04/09",
            gender: "female",
          },
        ],
      ]);
      cy.visit("/students");
    });

    it("Shows the students page", () => {});

    it("Shows a table with id, full name, email, birth date, gender, and created at columns", () => {
      const cols = [
        "Id",
        "Full name",
        "Email",
        "Birth date",
        "Gender",
        "Created at",
      ];
      cy.get("thead > tr").within(() => {
        cols.forEach((e, i) => cy.get("th").eq(i).contains(e));
      });
    });

    it("Shows a student with the correct id, full name, email birth date, and gender attributes", () => {
      const attrs = [
        1,
        "John Smith",
        "john@example.com",
        "2011-04-09",
        "female",
      ];
      cy.get("tbody > tr").within(() => {
        attrs.forEach((e, i) => cy.get("td").eq(i).contains(e));
      });
    });

    it("Shows a student with a created at attribute in the correct format", () => {
      cy.get("tbody > tr > td")
        .eq(5)
        .contains(/\d{4}-\d{2}-\d{2}\s\d{2}\:\d{2}\:\d{2}\s\w{3}/);
    });
  });

  describe("For many students", () => {
    beforeEach(() => {
      cy.app("clean");
      // explicitly set factory ids
      cy.appScenario("students");
      cy.visit("/students");
    });

    it("Shows the students page", () => {});

    it("Shows page navigation", () => {
      cy.get(".pagination").within(() => {
        cy.get("li.page-item.active");
        cy.get("a.page-link");
      });
    });

    it("Navigates to the different pages", () => {
      cy.get("a.page-link").each(($e, i) => {
        cy.get("a.page-link").eq(i).click(); //re-query element to avoid class changing
        cy.url().should("include", `/students?page=${i + 1}`);
      });
    });

    it.only("Displays different students on each page", () => {
      // need at least 2 pages to test this
      cy.get("a.page-link").its("length").should("be.gt", 1);

      // click first page
      cy.get("a.page-link").eq(0).click();

      // get id of first student
      cy.get("tbody > tr")
        .eq(0)
        .get("td")
        .eq(0)
        .invoke("text")
        .then((s) => {
          //then click second page
          cy.get("a.page-link").eq(1).click();

          // assert id of first student on second page is different
          cy.get("tbody > tr").eq(0).get("td").eq(0).should("not.have.text", s);
        });
    });
  });
});
