import {Line} from 'react-chartjs-2';

interface iProps {
  data: {[label: string]: [value: string]}
}

function AppLineChart({data}: iProps) {
  return (
      <Line
        data={{
          labels: Object.keys(data),
          datasets: [{
            data: Object.values(data),
            borderColor: 'rgb(255, 0, 0)',
            tension: 0.1
          }]
        }}
        options={{
          plugins: {
              legend: {
                  display: false
              }
          }
        }}
      />
  );
}

export default AppLineChart;
