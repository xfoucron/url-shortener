import { Controller } from '@hotwired/stimulus';

class ClipboardController extends Controller {
  static targets = ['content', 'button'];

  copy(event) {
    event.preventDefault();

    navigator.clipboard.writeText(this.contentTarget.value).then(() => {
      this.buttonTarget.innerHTML = 'Copied';
      setTimeout(async () => {
        this.buttonTarget.innerHTML = 'Copy';
      }, 1000);
    });
  }
}

export default ClipboardController;
