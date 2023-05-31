import { createElement } from 'lwc';
import LocationFilter from 'c/locationFilter';

describe('c-location-filter', () => {
  it('should update location value and dispatch event on location change', () => {
    const element = createElement('c-location-filter', {
      is: LocationFilter
    });
    document.body.appendChild(element);

    const locationInput = element.shadowRoot.querySelector('lightning-combobox');
    locationInput.dispatchEvent(new CustomEvent('change', { detail: { value: 'United States' } }));

    // Assert the dispatched event
    const locationChangeEvent = new CustomEvent('locationchange', {
      detail: { location: 'United States' }
    });
    expect(element.dispatchEvent).toHaveBeenCalledWith(locationChangeEvent);
  });
});
