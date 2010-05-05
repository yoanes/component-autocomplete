package au.com.sensis.mobile.web.component.autocomplete.datasource;

import java.util.List;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * Domain model for Yellow search suggestions. Maps to the data returned from
 * their JSON end point.
 *
 * @author Adrian.Koh2@sensis.com.au
 */
public class YellowSearchSuggestions {

    private String query;
    private List<String> suggestions;
    private List<String> data;

    /**
     * Default no arg constructor to support simple usage via the Jackson JSON API.
     */
    public YellowSearchSuggestions() {
    }

    /**
     * Construct with all data.
     *
     * @param query
     *            Query that was submitted to the Yellow search suggestions
     *            service.
     * @param suggestions
     *            List of suggestions returned from the Yellow Search
     *            Sugggestions Service.
     * @param data
     *            Data attached to each suggestion (??? not really sure what
     *            this and we don't use it but the Yellow Search Suggestions
     *            Service returns it.
     */
    public YellowSearchSuggestions(final String query,
            final List<String> suggestions, final List<String> data) {
        this.query = query;
        this.suggestions = suggestions;
        this.data = data;
    }

    /**
     * @return the query
     */
    public String getQuery() {
        return query;
    }

    /**
     * @param query
     *            the query to set
     */
    public void setQuery(final String query) {
        this.query = query;
    }

    /**
     * @return the data
     */
    public List<String> getData() {
        return data;
    }

    /**
     * @param data
     *            the data to set
     */
    public void setData(final List<String> data) {
        this.data = data;
    }

    /**
     * @return the suggestions
     */
    public List<String> getSuggestions() {
        return suggestions;
    }

    /**
     * @param suggestions
     *            the suggestions to set
     */
    public void setSuggestions(final List<String> suggestions) {
        this.suggestions = suggestions;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object obj) {
        if (this == obj) {
            return true;
        }

        if ((obj == null) || !this.getClass().equals(obj.getClass())) {
            return false;
        }

        final YellowSearchSuggestions rhs = (YellowSearchSuggestions) obj;
        final EqualsBuilder equalsBuilder = new EqualsBuilder();

        equalsBuilder.append(query, rhs.query);
        equalsBuilder.append(data, rhs.data);
        equalsBuilder.append(suggestions, rhs.suggestions);
        return equalsBuilder.isEquals();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        final HashCodeBuilder hashCodeBuilder = new HashCodeBuilder();
        hashCodeBuilder.append(query);
        hashCodeBuilder.append(data);
        hashCodeBuilder.append(suggestions);
        return hashCodeBuilder.toHashCode();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        final ToStringBuilder toStringBuilder = new ToStringBuilder(this);
        toStringBuilder.append("query", query);
        toStringBuilder.append("data", data);
        toStringBuilder.append("suggestions", suggestions);

        return toStringBuilder.toString();
    }


}
