import { createElement } from 'lwc';
import { registerApexTestWireAdapter } from '@salesforce/sfdx-lwc-jest';
import { getSuggestedFreelance } from 'data/freelanceService';
import SuggestedFreelanceTable from 'c/suggestedFreelanceTable';

// Register the Apex wire adapter
const getSuggestedFreelanceAdapter = registerApexTestWireAdapter(getSuggestedFreelance);

describe('c-suggested-freelance-table', () => {
  afterEach(() => {
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    jest.clearAllMocks();
  });

  it('displays the suggested freelancers', () => {
    // Create a mock list of suggested freelancers
    const mockFreelancers = [
      { Id: '001', FullName: 'John Doe', HourlyRate: 50, Location: 'United States' },
      { Id: '002', FullName: 'Jane Smith', HourlyRate: 60, Location: 'Canada' },
      { Id: '003', FullName: 'Mark Johnson', HourlyRate: 55, Location: 'Spain' }
    ];

    // Create a new instance of the SuggestedFreelanceTable component
    const element = createElement('c-suggested-freelance-table', {
      is: SuggestedFreelanceTable
    });

    // Append the component to the document body
    document.body.appendChild(element);

    // Emit the mock freelancers data
    getSuggestedFreelanceAdapter.emit(mockFreelancers);

    // Wait for any asynchronous DOM updates to complete
    return Promise.resolve().then(() => {
      // Assert the rendered freelancers
      const freelancerElements = element.shadowRoot.querySelectorAll('c-freelancer');
      expect(freelancerElements.length).toBe(3);

      // Assert the content of the first freelancer
      const firstFreelancer = freelancerElements[0];
      expect(firstFreelancer.fullName).toBe('John Doe');
      expect(firstFreelancer.hourlyRate).toBe(50);
      expect(firstFreelancer.location).toBe('United States');
    });
  });
});
