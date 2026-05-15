document.addEventListener('DOMContentLoaded', function() {
  const langButtons = document.querySelectorAll('.lang-btn');
  const blogCards = document.querySelectorAll('.blog-card');

  // Function to filter cards
  function filterCards(selectedLang) {
    blogCards.forEach(card => {
      const cardLang = card.getAttribute('data-lang');
      
      if (cardLang === selectedLang) {
        card.style.display = 'block';
        // Add fade-in animation
        card.style.opacity = '0';
        setTimeout(() => {
          card.style.opacity = '1';
          card.style.transition = 'opacity 0.3s ease-in-out';
        }, 50);
      } else {
        card.style.display = 'none';
      }
    });
  }

  // Initial filter on page load - show English articles
  filterCards('en');

  langButtons.forEach(button => {
    button.addEventListener('click', function() {
      const selectedLang = this.getAttribute('data-lang');
      
      // Update active button
      langButtons.forEach(btn => btn.classList.remove('active'));
      this.classList.add('active');
      
      // Filter blog cards
      filterCards(selectedLang);
    });
  });
});