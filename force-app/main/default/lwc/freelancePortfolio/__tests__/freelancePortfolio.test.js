import { createElement } from 'lwc';
import { registerApexTestWireAdapter } from '@salesforce/sfdx-lwc-jest';
import { getReviewsByFreelanceId } from 'data/reviewService';
import FreelancePortfolio from 'c/freelancePortfolio';

// Register the Apex wire adapter
const getReviewsByFreelanceIdAdapter = registerApexTestWireAdapter(getReviewsByFreelanceId);

describe('c-freelance-portfolio', () => {
  afterEach(() => {
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    jest.clearAllMocks();
  });

  it('displays the last three reviews for the freelance', () => {
    // Create a mock list of reviews
    const mockReviews = [
      { Id: '001', ProjectName: 'Project A', StartDate: '2023-01-01', Location: 'United States', TeamworkRate: 4, ProfessionalismRate: 5, ReliabilityRate: 4 },
      { Id: '002', ProjectName: 'Project B', StartDate: '2023-02-01', Location: 'Canada', TeamworkRate: 3, ProfessionalismRate: 4, ReliabilityRate: 5 },
      { Id: '003', ProjectName: 'Project C', StartDate: '2023-03-01', Location: 'Spain', TeamworkRate: 5, ProfessionalismRate: 3, ReliabilityRate: 4 }
    ];

    // Create a new instance of the FreelancePortfolio component
    const element = createElement('c-freelance-portfolio', {
      is: FreelancePortfolio
    });

    // Set the public property of the component
    element.freelanceId = '001'; // Replace with the actual freelance ID

    // Append the component to the document body
    document.body.appendChild(element);

    // Emit the mock reviews data
    getReviewsByFreelanceIdAdapter.emit(mockReviews);

    // Wait for any asynchronous DOM updates to complete
    return Promise.resolve().then(() => {
      // Assert the rendered reviews
      const reviewElements = element.shadowRoot.querySelectorAll('c-review');
      expect(reviewElements.length).toBe(3);

      // Assert the content of the first review
      const firstReview = reviewElements[0];
      expect(firstReview.projectName).toBe('Project A');
      expect(firstReview.startDate).toBe('2023-01-01');
      expect(firstReview.location).toBe('United States');
      expect(firstReview.teamworkRate).toBe(4);
      expect(firstReview.professionalismRate).toBe(5);
      expect(firstReview.reliabilityRate).toBe(4);
    });
  });
});
