(function () {
    const scriptEl = document.currentScript || document.querySelector('script[src*="action-kit.js"]');
    const scriptSrc = scriptEl ? scriptEl.src : '';
    const SITE_BASE = scriptSrc ? scriptSrc.replace(/scripts\/action-kit\.js(\?.*)?$/, '') : window.location.origin + '/';

    const buildDetailsUrl = (slug) => {
        if (!slug) return null;
        return SITE_BASE + 'resources/action-kit/' + slug + '.html';
    };

    const ACTION_KIT_ITEMS = [
        {
            id: 'power-mapping-lab',
            slug: 'power-mapping-lab',
            priority: 1,
            title: 'Power Mapping Lab',
            summary: 'Facilitate a structured session to map primary targets, influencers, and allies before you lock in campaign tactics.',
            focus: 'Campaign Strategy',
            format: 'Workshop Agenda',
            time: '90 min',
            team: '3-20 organizers',
            tags: ['campaigns', 'strategy', 'policy'],
            steps: [
                'Open with a shared win statement and name exactly who can grant it.',
                'Sketch the ecosystem: decision makers in the center, secondary influencers around them, and current/potential allies further out.',
                'Assign research or relationship owners to every influential node so follow-up actions are clear.'
            ],
            insight: 'Photograph the map at the end and convert it into a living doc so new teammates can plug in without repeating the session.'
        },
        {
            id: 'narrative-sprint-board',
            slug: 'narrative-sprint-board',
            priority: 2,
            title: 'Narrative Sprint Board',
            summary: 'A one-week storytelling cadence that keeps your message consistent across social, email, and press notes.',
            focus: 'Communications',
            format: 'Sprint Template',
            time: '60 min planning + async updates',
            team: 'Comms lead + partners',
            tags: ['communications', 'storytelling', 'digital'],
            steps: [
                'Pick one anchor story, supporting proof points, and a single call to action for the sprint.',
                'Plot channels (social, newsletter, op-ed, podcast pitch) along the columns and drop draft status cards beneath each.',
                'Host 15-minute async standups via comments or voice notes so everyone is unblocked without extra meetings.'
            ],
            insight: 'Save past sprint boards to spot what messages earned press or conversions, then reuse those high performers when news breaks.'
        },
        {
            id: 'rapid-response-call-circle',
            slug: 'rapid-response-call-circle',
            priority: 3,
            title: 'Rapid Response Call Circle',
            summary: 'Build a cascading check-in tree that lets you brief and mobilize hundreds of people in under 30 minutes.',
            focus: 'Mobilization',
            format: 'Checklist',
            time: 'Prep once, deploy anytime',
            team: '10-200 volunteers',
            tags: ['community', 'direct-action', 'campaigns'],
            steps: [
                'Segment supporters into pods of 8-10 and assign a captain plus a backup for each pod.',
                'Write two sample scripts: one for informational updates and one for tactical mobilizations with clear yes/no asks.',
                'After each deployment, log responses (ready, unavailable, follow-up) to keep participation data fresh.'
            ],
            insight: 'Use shared spreadsheets or tools like CallHub to auto-track who connected so captains can escalate gaps fast.'
        },
        {
            id: 'mutual-aid-drop-spot',
            slug: 'mutual-aid-drop-spot',
            priority: 4,
            title: 'Mutual Aid Drop Spot Playbook',
            summary: 'Stand up a weekend pop-up where neighbors can leave or pick up supplies without bureaucracy.',
            focus: 'Mutual Aid',
            format: 'Playbook',
            time: '2-3 hours setup',
            team: '4-8 hosts',
            tags: ['community', 'mutual-aid', 'logistics'],
            steps: [
                'Map a location that is ADA accessible, near transit, and has weather protection or shade.',
                'Create three clearly labeled zones: intake, sorting, and community shopping with posted guidelines.',
                'Track requests and donations in a simple sheet so you know what to promote on social each week.'
            ],
            insight: 'Pair the drop spot with a feedback wall or QR survey to surface unmet needs from community members in real time.'
        },
        {
            id: 'press-day-toolkit',
            slug: 'press-day-toolkit',
            priority: 5,
            title: 'Press Day Toolkit',
            summary: 'Everything you need for a 24-hour earned media push around a new report, action, or story.',
            focus: 'Media Outreach',
            format: 'Template Pack',
            time: 'Half-day build',
            team: 'Spokespeople + comms',
            tags: ['communications', 'press', 'digital'],
            steps: [
                'Draft a two-paragraph media advisory with quotable lines and link it to a Dropbox with photos and b-roll.',
                'Pre-brief at least three friendly reporters or newsletters under embargo so coverage lands simultaneously.',
                'Schedule social proof (ally quotes, infographic) to drop as soon as the first story publishes.'
            ],
            insight: 'Keep a rolling “bench” of local validators so you can swap quotes in minutes without chasing approvals.'
        },
        {
            id: 'volunteer-onboarding-flow',
            slug: 'volunteer-onboarding-flow',
            priority: 6,
            title: 'Volunteer Onboarding Flow',
            summary: 'Move supporters from sign-up form to first meaningful task within five days.',
            focus: 'Organizing Operations',
            format: 'Workflow',
            time: 'Build once, automate',
            team: 'Operations + team leads',
            tags: ['organizing', 'coalitions', 'people-care'],
            steps: [
                'Send an immediate welcome email that names two concrete roles (e.g., researcher, field captain) and links a short interest survey.',
                'Book new volunteers into a 30-minute orientation block that ends with them choosing a starter task.',
                'Pair each new person with a peer buddy and auto-schedule their first check-in using Calendly or Luma.'
            ],
            insight: 'Track conversion rates between each step so you can tweak scripts or timing where people drop off.'
        },
        {
            id: 'grassroots-budget-scenarios',
            slug: 'grassroots-budget-scenarios',
            priority: 7,
            title: 'Grassroots Budget Scenario Builder',
            summary: 'Quickly stress-test three funding scenarios so you can decide where to invest limited dollars.',
            focus: 'Fundraising + Operations',
            format: 'Spreadsheet Template',
            time: '60 min',
            team: 'Finance + program owners',
            tags: ['fundraising', 'planning', 'operations'],
            steps: [
                'List fixed costs (staff stipends, software, insurance) and variable costs (events, travel) on separate tabs.',
                'Model conservative, likely, and stretch income projections that include grassroots gifts, grants, and earned revenue.',
                'Translate each scenario into “what we can greenlight” statements so program leads know the stakes.'
            ],
            insight: 'Share the stretch scenario publicly to invite supporters into the math and inspire specific sponsorships.'
        },
        {
            id: 'digital-security-checkup',
            slug: 'digital-security-checkup',
            priority: 8,
            title: 'Digital Security Checkup',
            summary: 'A quarterly ritual that keeps devices, accounts, and sensitive data hardened.',
            focus: 'Security + Care',
            format: 'Checklist',
            time: '45 min',
            team: 'Everyone',
            tags: ['digital', 'security', 'wellbeing'],
            steps: [
                'Rotate passwords with a manager like Bitwarden and confirm multi-factor auth is on for every shared account.',
                'Audit collaboration tools (Docs, Slack, Airtable) and remove anyone who no longer needs access.',
                'Document incident contacts (lawyer, tech ally, rapid responder) on a laminated card or offline note.'
            ],
            insight: 'Pair the checkup with a wellbeing practice—hydration break, stretch, breathing—to reinforce that safety and care go hand in hand.'
        },
        {
            id: 'corporate-pressure-brief',
            slug: 'corporate-pressure-brief',
            priority: 9,
            title: 'Corporate Pressure Brief',
            summary: 'Convert raw research into a two-page brief that helps supporters push a company or donor to move.',
            focus: 'Research + Accountability',
            format: 'Brief Template',
            time: 'Half-day',
            team: 'Research + spokespeople',
            tags: ['corporate', 'policy', 'campaigns'],
            steps: [
                'Open with the public demand and the exact policy or dollar shift you expect from the company.',
                'Summarize leverage points—shareholder meetings, vendor contracts, employee resource groups—and match them to tactics.',
                'Close with two scripts: one for supporters (emails, calls) and one for insider champions.'
            ],
            insight: 'Include a heat map of where the company operates so local chapters can localize pressure quickly.'
        },
        {
            id: 'healing-circle-routine',
            slug: 'healing-circle-routine',
            priority: 10,
            title: 'Healing Circle Routine',
            summary: 'A steady format for debriefing wins and losses without burning out your core team.',
            focus: 'Wellbeing',
            format: 'Facilitation Guide',
            time: '30-45 min',
            team: 'Any team size',
            tags: ['wellbeing', 'healing', 'community'],
            steps: [
                'Set agreements (confidentiality, no cross-talk, step up/step back) and open with a short grounding exercise.',
                'Invite each person to share one high, one low, and one request for support using a talking piece.',
                'Close with a collective decision: what gets paused, delegated, or resourced differently based on what surfaced.'
            ],
            insight: 'Rotate facilitators so care work is shared, and log anonymized themes to inform future staffing or partnerships.'
        },
        {
            id: 'policy-one-pager-studio',
            slug: 'policy-one-pager-studio',
            priority: 11,
            title: 'Policy One-Pager Studio',
            summary: 'Translate complex legislation into a friendly explainer you can hand to officials or volunteers.',
            focus: 'Policy Education',
            format: 'Studio Session',
            time: '75 min',
            team: 'Writers + policy leads',
            tags: ['policy', 'education', 'communications'],
            steps: [
                'Write a human-centered lead that names the problem, the people most affected, and the fix you propose.',
                'Break the policy into three digestible sections: what it does, how it will be paid for, and what happens if it fails.',
                'Add a micro story or quote plus a QR code that links to deeper research or petitions.'
            ],
            insight: 'Keep the design modular so you can swap stats or stories for different districts without redoing the layout.'
        }
    ];

    const computeSearchText = (item) => {
        return [
            item.title,
            item.summary,
            item.focus,
            item.format,
            item.time,
            item.team,
            item.tags.join(' '),
            item.steps.join(' '),
            item.insight || ''
        ].join(' ').toLowerCase();
    };

    const uniqueTags = ACTION_KIT_ITEMS.reduce((set, item) => {
        item.tags.forEach(tag => set.add(tag));
        return set;
    }, new Set());

    const ALL_TAGS = Array.from(uniqueTags).sort();

    const pickItemsByTags = (tags, limit) => {
        const requested = (tags || []).filter(Boolean);
        let pool = ACTION_KIT_ITEMS.slice().sort((a, b) => (a.priority || 99) - (b.priority || 99));
        if (requested.length) {
            const filtered = pool.filter(item => requested.some(tag => item.tags.includes(tag)));
            if (filtered.length) {
                pool = filtered;
            }
        }
        return typeof limit === 'number' ? pool.slice(0, limit) : pool;
    };

    const createCard = (item, options = {}) => {
        const { compact = false } = options;
        const detailsUrl = buildDetailsUrl(item.slug);
        const card = document.createElement('div');
        card.className = 'action-kit-card' + (compact ? ' action-kit-card-compact' : '');
        card.dataset.searchable = '';
        card.dataset.category = 'Action Kit';
        card.dataset.search = computeSearchText(item);

        const stepLimit = compact ? Math.min(2, item.steps.length) : item.steps.length;
        const stepsHtml = item.steps.slice(0, stepLimit).map(step => `<li>${step}</li>`).join('');
        const tagsHtml = item.tags.map(tag => `<span class="action-kit-tag">#${tag}</span>`).join('');

        card.innerHTML = `
            <div class="action-kit-card-meta">
                <span class="action-kit-pill">${item.format}</span>
                <span class="action-kit-pill pill-muted">${item.time}</span>
                <span class="action-kit-pill pill-muted">${item.team}</span>
            </div>
            <div class="action-kit-focus">${item.focus}</div>
            <h4 class="action-kit-name">${item.title}</h4>
            <p class="action-kit-summary">${item.summary}</p>
            <ul class="action-kit-steps">${stepsHtml}</ul>
            ${!compact && item.insight ? `<p class="action-kit-tip">${item.insight}</p>` : ''}
            <div class="action-kit-tags">${tagsHtml}</div>
            ${detailsUrl ? `<a class="action-kit-open" href="${detailsUrl}">Open full kit</a>` : ''}
        `;

        return card;
    };

    const mountActionKitPanel = () => {
        const grid = document.querySelector('[data-action-kit-grid]');
        if (!grid) {
            return;
        }

        const filtersHost = document.querySelector('[data-action-kit-filters]');
        const searchInput = document.querySelector('[data-action-kit-search]');
        const countEl = document.querySelector('[data-action-kit-count]');
        let activeTag = 'all';

        if (filtersHost) {
            const frag = document.createDocumentFragment();
            const createButton = (label, value) => {
                const button = document.createElement('button');
                button.className = 'action-kit-filter';
                button.textContent = label;
                button.dataset.filterValue = value;
                if (value === 'all') {
                    button.classList.add('active');
                }
                button.addEventListener('click', () => {
                    filtersHost.querySelectorAll('.action-kit-filter').forEach(btn => btn.classList.remove('active'));
                    button.classList.add('active');
                    activeTag = value;
                    render();
                });
                return button;
            };
            frag.appendChild(createButton('All focuses', 'all'));
            ALL_TAGS.forEach(tag => {
                frag.appendChild(createButton(`#${tag}`, tag));
            });
            filtersHost.appendChild(frag);
        }

        const render = () => {
            const query = searchInput ? searchInput.value.trim().toLowerCase() : '';
            let items = pickItemsByTags(activeTag === 'all' ? [] : [activeTag]);
            if (query) {
                items = items.filter(item => computeSearchText(item).includes(query));
            }
            grid.innerHTML = '';
            if (!items.length) {
                const empty = document.createElement('p');
                empty.className = 'action-kit-empty';
                empty.textContent = 'No kits match that filter yet. Try a different focus or clear the search.';
                grid.appendChild(empty);
                if (countEl) {
                    countEl.textContent = '0 kits';
                }
                return;
            }
            const fragment = document.createDocumentFragment();
            items.forEach(item => fragment.appendChild(createCard(item)));
            grid.appendChild(fragment);
            if (countEl) {
                countEl.textContent = items.length + (items.length === 1 ? ' kit' : ' kits');
            }
        };

        if (searchInput) {
            searchInput.addEventListener('input', render);
        }

        render();
    };

    const mountEmbeds = () => {
        const embeds = document.querySelectorAll('.action-kit-embed');
        if (!embeds.length) {
            return;
        }
        embeds.forEach(container => {
            const tagsAttr = container.dataset.actionTags || '';
            const tags = tagsAttr.split(',').map(tag => tag.trim()).filter(Boolean);
            const limit = Number(container.dataset.limit) || 3;
            const headingText = container.dataset.heading || 'Action Kit: Put this into practice';
            const items = pickItemsByTags(tags, limit);
            if (!items.length) {
                return;
            }
            const heading = document.createElement('h3');
            heading.className = 'action-kit-embed-heading';
            heading.textContent = headingText;

            const grid = document.createElement('div');
            grid.className = 'action-kit-grid action-kit-grid-compact';
            const fragment = document.createDocumentFragment();
            items.forEach(item => fragment.appendChild(createCard(item, { compact: true })));
            grid.appendChild(fragment);

            const linkNeeded = container.dataset.showLink === 'true';
            container.innerHTML = '';
            container.classList.add('action-kit-embed-ready');
            container.appendChild(heading);
            container.appendChild(grid);

            if (linkNeeded) {
                const link = document.createElement('a');
                link.href = SITE_BASE + 'resources.html#panel-action-kit';
                link.className = 'action-kit-link';
                link.textContent = 'Browse the full Action Kit →';
                container.appendChild(link);
            }
        });
    };

    document.addEventListener('DOMContentLoaded', () => {
        mountActionKitPanel();
        mountEmbeds();
    });

    window.ActionKit = {
        items: ACTION_KIT_ITEMS.slice(),
        getItems: () => ACTION_KIT_ITEMS.slice(),
        getTags: () => ALL_TAGS.slice()
    };
})();
